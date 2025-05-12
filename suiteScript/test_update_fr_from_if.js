/**
 * @NApiVersion 2.x
 * @NScriptType UserEventScript
 * @NModuleScope SameAccount
 */
define(['N/record', 'N/log'], function(record, log) {

    // This is deployed as an on edit event type trigger
    function afterSubmit(context) {
        var fulfillment = context.newRecord;
        
        // Get the 'memo' field from the Item Fulfillment record
        var itemFulfillmentMemo = fulfillment.getValue({ fieldId: 'memo' });

        // Check if the memo is set to 'test'
        if (itemFulfillmentMemo === 'test') {
            // Get the 'requestedBy' field value, which is the Fulfillment Request ID
            var fulfillmentRequestId = fulfillment.getValue({ fieldId: 'requestedby' });

            // Ensure the requestedBy field has a value (i.e., it's linked to a Fulfillment Request)
            if (fulfillmentRequestId) {
                try {
                    // Load the Fulfillment Request record
                    var frRecord = record.load({
                        type: 'fulfillmentrequest', // Use the correct record type ID for your custom record
                        id: fulfillmentRequestId
                    });

                    // Set the memo field of the Fulfillment Request to 'updated'
                    frRecord.setValue({
                        fieldId: 'memo',  // Replace with the actual field ID for the memo on Fulfillment Request
                        value: 'updated'
                    });

                    // Save the Fulfillment Request record
                    frRecord.save();

                    log.debug({
                        title: 'Fulfillment Request Memo Updated',
                        details: 'Fulfillment Request ' + fulfillmentRequestId + ' memo has been updated to "updated".'
                    });

                } catch (e) {
                    // Log any errors that occur
                    log.error({
                        title: 'Error updating Fulfillment Request memo',
                        details: e.message
                    });
                }
            }
        }
    }

    return {
        afterSubmit: afterSubmit
    };
});
