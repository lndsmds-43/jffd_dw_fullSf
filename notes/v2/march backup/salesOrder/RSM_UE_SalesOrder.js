/**
 * Copyright         2022 RSM US LLP
 * Description       Script to create FRs
 * Collaborative Link:  N/A
 * Local Repo Link:  N/A
 *
 * @NApiVersion 2.1
 * @NScriptType UserEventScript
 */
(function (factory) {
    if (typeof module === "object" && typeof module.exports === "object") {
        var v = factory(require, exports);
        if (v !== undefined) module.exports = v;
    }
    else if (typeof define === "function" && define.amd) {
        define(["require", "exports", "./NFT-SS2-7.2.0/EC_Logger", "N/record", "./NFT-SS2-7.2.0/immutable", "./NFT-SS2-7.2.0/search", "N/search", "./NFT-SS2-7.2.0/lodash", "./RecordTypes/FulfillmentRequest", "./RecordTypes/SalesOrder", "N/runtime"], factory);
    }
})(function (require, exports) {
    "use strict";
    const LogManager = require("./NFT-SS2-7.2.0/EC_Logger");
    const record = require("N/record");
    const immutable_1 = require("./NFT-SS2-7.2.0/immutable");
    const search_1 = require("./NFT-SS2-7.2.0/search");
    const search = require("N/search");
    const _ = require("./NFT-SS2-7.2.0/lodash");
    const FulfillmentRequest_1 = require("./RecordTypes/FulfillmentRequest");
    const SalesOrder_1 = require("./RecordTypes/SalesOrder");
    const runtime = require("N/runtime");
    const log = LogManager.DefaultLogger;

    var X;
    (function (X) {
        /**
         * afterSubmit entrypoint
         */
        function afterSubmit(ctx) {
            if (ctx.type === ctx.UserEventType.EDIT || ctx.type === ctx.UserEventType.CREATE) {
                try {
                    const salesOrder = new SalesOrder_1.SalesOrder(ctx.newRecord.id);
                    log.debug('Sales Order - New', salesOrder);

                    let currentScript = runtime.getCurrentScript();
                    const errorItem = currentScript.getParameter({ name: 'custscript_rsm_edi_error_item' });

                    // Ensure we exclude EDI error item
                    if (Number(salesOrder.item[0].item) !== Number(errorItem)) {
                        const oldSalesOrder = new SalesOrder_1.SalesOrder(ctx.oldRecord);
                        log.debug('Sales Order - Old', oldSalesOrder);

                        let saveErrors = [];
                        let successfulSave = true;
                        const linksSublist = salesOrder.links;
                        log.debug('Links', linksSublist);

                        const frFound = _.findIndex(linksSublist, item => item['type'] == 'Fulfillment Request');
                        log.debug('FR Found', frFound);

                        // If there are no pre-existing FRs
                        if (Number(frFound) === -1) {
                            // Search for Amazon/Chewy customers
                            const customerSearch = (0, immutable_1.Seq)(search_1.LazySearch.from(search.create({
                                type: 'customer',
                                filters: [
                                    [["companyname", "contains", "Amazon"], "OR", ["companyname", "contains", "Chewy"], "OR", ["companyname", "contains", "mwi"], "OR", ["companyname", "contains", "Petco"], "OR", ["companyname", "contains", "Pet Food Express"]],
                                    'AND',
                                    ["internalid", "anyof", salesOrder.entity]
                                ],
                                columns: [search.createColumn({ name: 'internalid', label: 'Internal ID' })]
                            })));

                            const customerSearchResults = customerSearch.map((0, search_1.nsSearchResult2obj)(false)).toArray();
                            log.debug('customerSearchResults', customerSearchResults);

                            // The Customer is Amazon, Chewy, MWI, or the status changed to submitted
                            if ((customerSearchResults.length > 0 && Number(salesOrder.custbody_jffd_fr_create_status) !== 3) ||
                                (Number(salesOrder.custbody_jffd_fr_create_status) === 2)) {

                                const inputSearch = (0, immutable_1.Seq)(search_1.LazySearch.from(search.create({
                                    type: 'transaction',
                                    settings: [{ 'name': 'consolidationtype', 'value': 'ACCTTYPE' }],
                                    filters: [
                                        ['internalidnumber', 'equalto', salesOrder.id],
                                        'AND',
                                        ['mainline', 'is', 'F'],
                                        'AND',
                                        ['location.locationtype', 'anyof', '2']
                                    ],
                                    columns: [
                                        search.createColumn({ name: 'location', summary: search.Summary.GROUP, label: 'Location' }),
                                        search.createColumn({ name: 'custcol_jffd_storage_temp', summary: search.Summary.GROUP, label: 'Storage Temperature' })
                                    ]
                                })));

                                const inputSearchResults = inputSearch.map((0, search_1.nsSearchResult2obj)(false)).toArray();
                                log.debug('Search Results', inputSearchResults);

                                if (inputSearchResults.length > 0) {
                                    // Resetting Error Message
                                    salesOrder.custbody_rsm_error_message = '';
                                    let itemSublist = salesOrder.item.toJSON();
                                    log.debug('itemSublist', itemSublist);

                                    // Separate ASC locations
                                    const ascLocations = inputSearchResults.filter(line => line.locationText.includes("ASC"));

                                    if (ascLocations.length > 0) {
                                        log.debug('Handling ASC Locations', ascLocations);
                                        const fulfillmentRequest = new FulfillmentRequest_1.FulfillmentRequest(record.transform({
                                            fromType: 'salesorder',
                                            fromId: _.toNumber(salesOrder.id),
                                            toType: 'fulfillmentrequest',
                                            isDynamic: true
                                        }));
                                        //_.forEach(ascLocations, function (line) {
                                            _.forEach(fulfillmentRequest.item, function (item, index) {
                                                item.itemreceive = true;
                                                item.custcol_jffd_cust_po_line_num = item.line;
                                            });
                                            fulfillmentRequest.custbody_jffd_send_850_status = 2;
                                       // });
                                        let save = fulfillmentRequest.save();

                                        if (!save) {
                                            saveErrors.push('Error creating FR for location ');
                                            successfulSave = false;
                                        }
                                        // Save the Sales Order after ASC processing
                                        salesOrder.custbody_jffd_fr_create_status = successfulSave ? 3 : 4;
                                        salesOrder.custbody_rsm_error_message = saveErrors.join(', ');
                                        salesOrder.save(true, true);
                                    } else {
                                        log.debug('Handling Non-ASC Locations', inputSearchResults)

                                        _.forEach(inputSearchResults, function (line) {
                                            const result = itemSublist.filter(item => Number(item['location']) === Number(line.location));
                                            log.debug('Filter Result', result);

                                            if (!_.isEmpty(result)) {
                                                const fulfillmentRequest = new FulfillmentRequest_1.FulfillmentRequest(record.transform({
                                                    fromType: 'salesorder',
                                                    fromId: _.toNumber(salesOrder.id),
                                                    toType: 'fulfillmentrequest',
                                                    isDynamic: true
                                                }));

                                                _.forEach(fulfillmentRequest.item, function (item, index) {
                                                    log.debug('Result', item.location + '---' + line.location);
                                                    if ((item.location === line.location) && (item.custcol_jffd_storage_temp === line.custcol_jffd_storage_temp)) {
                                                        log.debug('Items Match');
                                                        item.itemreceive = true;
                                                        item.custcol_jffd_cust_po_line_num = item.line;
                                                    } else {
                                                        log.debug('Items Do Not Match');
                                                        item.itemreceive = false;
                                                    }
                                                });

                                                fulfillmentRequest.custbody_jffd_send_850_status = 2;
                                                let save = fulfillmentRequest.save();

                                                if (!save) {
                                                    saveErrors.push('Error creating FR for location ' + line.location);
                                                    successfulSave = false;
                                                }
                                            }
                                        });

                                        salesOrder.custbody_jffd_fr_create_status = successfulSave ? 3 : 4;
                                        salesOrder.custbody_rsm_error_message = saveErrors.join(', ');
                                        salesOrder.save(true, true);
                                    }
                                }
                            }
                        }
                    }
                } catch (e) {
                    log.debug('Error', e);
                }
            }
        }
        X.afterSubmit = afterSubmit;
    })(X || (X = {}));
    return { afterSubmit: X.afterSubmit };
});
