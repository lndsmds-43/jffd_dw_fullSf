/**
 * @NApiVersion 2.x
 * @NScriptType UserEventScript
 */
define(['N/record', 'N/log'], function (record, log) {

    function getStringBetween(str, startDelimiter, endDelimiter) {
        var startIndex = str.indexOf(startDelimiter);
        var endIndex = str.indexOf(endDelimiter);

        if (startIndex !== -1 && endIndex !== -1 && startIndex < endIndex) {
            return str.substring(startIndex + startDelimiter.length, endIndex);
        }
        return '';
    }

    function afterSubmit(context) {
        if (context.type !== 'edit') {
            return;
        }

        var salesOrder = context.newRecord;
        var memo = salesOrder.getValue('memo');

        if (!memo || memo.indexOf('frUpdate') !== 0) {
            return;
        }

        var updatesAsString = getStringBetween(memo, "{", "}");
        if (!updatesAsString) return;

        var updatesArray = updatesAsString.split(",").map(function(s) {
            return s.trim();
        });

        for (var i = 0; i < updatesArray.length; i++) {
            var update = updatesArray[i];
            var obj = update.split(":");

            if (obj.length < 2) {
                log.error({
                    title: 'Malformed update entry',
                    details: update
                });
                continue;
            }

            var frId = obj[0];
            var status = obj[1];

            try {
                var frRecord = record.load({
                    type: 'fulfillmentrequest', // Replace with correct record type if needed
                    id: frId
                });

                frRecord.setValue({
                    fieldId: 'memo', // Replace with correct field ID if needed
                    value: status
                });

                frRecord.save();

                log.debug({
                    title: 'Updated FR',
                    details: 'ID: ' + frId + ', Memo: ' + status
                });

            } catch (e) {
                log.error({
                    title: 'Failed to update FR ' + frId,
                    details: e.message || JSON.stringify(e)
                });
            }
        }
    }

    return {
        afterSubmit: afterSubmit
    };
});
