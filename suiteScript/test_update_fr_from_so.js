/**
 * @NApiVersion 2.x
 * @NScriptType UserEventScript
 */
define(['N/record', 'N/log'], function(record, log) {

    function afterSubmit(context) {
        if (context.type !== context.UserEventType.EDIT) {
            return;
        }

        var salesOrder = context.newRecord;
        var memo = salesOrder.getValue('memo');

        if (!memo || memo.indexOf('frUpdate ') !== 0) {
            return;
        }

        // Extract the JSON string from the memo
        var jsonStr = memo.substring(9).trim();
        var frMap;

        try {
            frMap = JSON.parse(jsonStr); // requires strict JSON: keys/values in double quotes
        } catch (e) {
            log.error({
                title: 'Invalid JSON in memo',
                details: e.message
            });
            return;
        }

        for (var frId in frMap) {
            if (frMap.hasOwnProperty(frId)) {
                try {
                    var frRecord = record.load({
                        type: 'fulfillmentrequest', // Replace with actual record type if different
                        id: frId
                    });

                    frRecord.setValue({
                        fieldId: 'memo', // Replace with actual field ID if necessary
                        value: frMap[frId]
                    });

                    frRecord.save();

                    log.debug({
                        title: 'Updated FR',
                        details: 'ID: ' + frId + ', Memo: ' + frMap[frId]
                    });
                } catch (e) {
                    log.error({
                        title: 'Failed to update FR ' + frId,
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
