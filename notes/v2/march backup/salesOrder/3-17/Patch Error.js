INFO  2025-03-17 19:43:27,756 [[MuleRuntime].uber.01: [msi-sfdc-sys].patch-fulfillmentOrder-req.BLOCKING @1dc7746a] [processor: patch-fulfillmentOrder-req/processors/2; event: 9e050f60-0389-11f0-ac1c-00e04c614871] org.mule.extension.jsonlogger.JsonLogger: {
  "correlationId" : "9e050f60-0389-11f0-ac1c-00e04c614871",
  "message" : "patch-fulfillmentOrder-req - Flow end",
  "tracePoint" : "AFTER_REQUEST",
  "priority" : "INFO",
  "elapsed" : 3228,
  "locationInfo" : {
    "lineInFile" : "75",
    "component" : "json-logger:logger",
    "fileName" : "implementation/patch-fulfillmentOrder.xml",
    "rootContainer" : "patch-fulfillmentOrder-req"
  },
  "timestamp" : "2025-03-17T23:43:27.751Z",
  "content" : {
    "sfPatchResponse" : {
      "id" : null,
      "items" : [ {
        "exception" : {
          "localizedMessage" : "Fulfillment Order ID: id value of incorrect type: 0a3VF0000002eXdYAIe MALFORMED_ID",
          "cause" : null,
          "message" : "Fulfillment Order ID: id value of incorrect type: 0a3VF0000002eXdYAIe MALFORMED_ID",
          "stackTrace" : [ {
            "fileName" : "BulkOperationResultMapper.java",
            "methodName" : "lambda$map$0",
            "className" : "org.mule.extension.salesforce.internal.mapper.BulkOperationResultMapper",
            "nativeMethod" : false,
            "lineNumber" : 36
          }, {
            "fileName" : "ArrayList.java",
            "methodName" : "forEach",
            "className" : "java.util.ArrayList",
            "nativeMethod" : false,
            "lineNumber" : 1259
          }, {
            "fileName" : "BulkOperationResultMapper.java",
            "methodName" : "map",
            "className" : "org.mule.extension.salesforce.internal.mapper.BulkOperationResultMapper",
            "nativeMethod" : false,
            "lineNumber" : 26
          }, {
            "fileName" : "CoreServiceImpl.java",
            "methodName" : "update",
            "className" : "org.mule.extension.salesforce.internal.service.CoreServiceImpl",
            "nativeMethod" : false,
            "lineNumber" : 172
          }, {
            "fileName" : "UpdateOperation.java",
            "methodName" : "update",
            "className" : "org.mule.extension.salesforce.internal.operation.core.UpdateOperation",
            "nativeMethod" : false,
            "lineNumber" : 56
          }, {
            "fileName" : null,
            "methodName" : "execute",
            "className" : "org.mule.extension.salesforce.internal.operation.core.UpdateOperation$update$MethodComponentExecutor_msi_sfdc_sys",
            "nativeMethod" : false,
            "lineNumber" : -1
          }, {
            "fileName" : "GeneratedMethodComponentExecutor.java",
            "methodName" : "execute",
            "className" : "org.mule.runtime.module.extension.internal.runtime.execution.GeneratedMethodComponentExecutor",
            "nativeMethod" : false,
            "lineNumber" : 94
          }, {
            "fileName" : "CompletableMethodOperationExecutor.java",
            "methodName" : "doExecute",
            "className" : "org.mule.runtime.module.extension.internal.runtime.execution.CompletableMethodOperationExecutor",
            "nativeMethod" : false,
            "lineNumber" : 26
          }, {
            "fileName" : "AbstractCompletableMethodOperationExecutor.java",
            "methodName" : "execute",
            "className" : "org.mule.runtime.module.extension.internal.runtime.execution.AbstractCompletableMethodOperationExecutor",
            "nativeMethod" : false,
            "lineNumber" : 61
          }, {
            "fileName" : "DefaultExecutionMediator.java",
            "methodName" : "executeCommand",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.DefaultExecutionMediator",
            "nativeMethod" : false,
            "lineNumber" : 254
          }, {
            "fileName" : "DefaultExecutionMediator.java",
            "methodName" : "lambda$executeWithInterceptors$6",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.DefaultExecutionMediator",
            "nativeMethod" : false,
            "lineNumber" : 235
          }, {
            "fileName" : "DefaultExecutionMediator.java",
            "methodName" : "lambda$executeWithRetry$2",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.DefaultExecutionMediator",
            "nativeMethod" : false,
            "lineNumber" : 211
          }, {
            "fileName" : "Functions.java",
            "methodName" : "lambda$toCtxSupplier$15",
            "className" : "net.jodah.failsafe.Functions",
            "nativeMethod" : false,
            "lineNumber" : 298
          }, {
            "fileName" : "Functions.java",
            "methodName" : "lambda$getPromiseOfStage$7",
            "className" : "net.jodah.failsafe.Functions",
            "nativeMethod" : false,
            "lineNumber" : 174
          }, {
            "fileName" : "Functions.java",
            "methodName" : "lambda$null$3",
            "className" : "net.jodah.failsafe.Functions",
            "nativeMethod" : false,
            "lineNumber" : 107
          }, {
            "fileName" : "ConditionalExecutorServiceDecorator.java",
            "methodName" : "synchronousSchedule",
            "className" : "org.mule.runtime.core.internal.util.rx.ConditionalExecutorServiceDecorator",
            "nativeMethod" : false,
            "lineNumber" : 181
          }, {
            "fileName" : "ConditionalExecutorServiceDecorator.java",
            "methodName" : "schedule",
            "className" : "org.mule.runtime.core.internal.util.rx.ConditionalExecutorServiceDecorator",
            "nativeMethod" : false,
            "lineNumber" : 167
          }, {
            "fileName" : "Functions.java",
            "methodName" : "lambda$getPromiseAsync$5",
            "className" : "net.jodah.failsafe.Functions",
            "nativeMethod" : false,
            "lineNumber" : 116
          }, {
            "fileName" : "RetryPolicyExecutor.java",
            "methodName" : "call",
            "className" : "net.jodah.failsafe.RetryPolicyExecutor$1",
            "nativeMethod" : false,
            "lineNumber" : 116
          }, {
            "fileName" : "RetryPolicyExecutor.java",
            "methodName" : "lambda$supplyAsync$1",
            "className" : "net.jodah.failsafe.RetryPolicyExecutor",
            "nativeMethod" : false,
            "lineNumber" : 168
          }, {
            "fileName" : "AsyncExecution.java",
            "methodName" : "executeAsync",
            "className" : "net.jodah.failsafe.AsyncExecution",
            "nativeMethod" : false,
            "lineNumber" : 184
          }, {
            "fileName" : "FailsafeExecutor.java",
            "methodName" : "callAsync",
            "className" : "net.jodah.failsafe.FailsafeExecutor",
            "nativeMethod" : false,
            "lineNumber" : 414
          }, {
            "fileName" : "FailsafeExecutor.java",
            "methodName" : "getStageAsync",
            "className" : "net.jodah.failsafe.FailsafeExecutor",
            "nativeMethod" : false,
            "lineNumber" : 158
          }, {
            "fileName" : "SimpleRetryPolicy.java",
            "methodName" : "applyPolicy",
            "className" : "org.mule.runtime.core.internal.retry.policies.SimpleRetryPolicy",
            "nativeMethod" : false,
            "lineNumber" : 95
          }, {
            "fileName" : "RetryPolicyTemplate.java",
            "methodName" : "applyPolicy",
            "className" : "org.mule.runtime.core.api.retry.policy.RetryPolicyTemplate",
            "nativeMethod" : false,
            "lineNumber" : 145
          }, {
            "fileName" : "DefaultExecutionMediator.java",
            "methodName" : "executeWithRetry",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.DefaultExecutionMediator",
            "nativeMethod" : false,
            "lineNumber" : 209
          }, {
            "fileName" : "DefaultExecutionMediator.java",
            "methodName" : "executeWithInterceptors",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.DefaultExecutionMediator",
            "nativeMethod" : false,
            "lineNumber" : 235
          }, {
            "fileName" : "DefaultExecutionMediator.java",
            "methodName" : "lambda$execute$1",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.DefaultExecutionMediator",
            "nativeMethod" : false,
            "lineNumber" : 144
          }, {
            "fileName" : "DefaultExecutionMediator.java",
            "methodName" : "lambda$new$0",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.DefaultExecutionMediator",
            "nativeMethod" : false,
            "lineNumber" : 80
          }, {
            "fileName" : "DefaultExecutionMediator.java",
            "methodName" : "withExecutionTemplate",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.DefaultExecutionMediator",
            "nativeMethod" : false,
            "lineNumber" : 335
          }, {
            "fileName" : "DefaultExecutionMediator.java",
            "methodName" : "execute",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.DefaultExecutionMediator",
            "nativeMethod" : false,
            "lineNumber" : 143
          }, {
            "fileName" : "ComponentMessageProcessor.java",
            "methodName" : "executeOperation",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.ComponentMessageProcessor",
            "nativeMethod" : false,
            "lineNumber" : 582
          }, {
            "fileName" : "OAuthOperationMessageProcessor.java",
            "methodName" : "executeOperation",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.OAuthOperationMessageProcessor",
            "nativeMethod" : false,
            "lineNumber" : 66
          }, {
            "fileName" : "ComponentMessageProcessor.java",
            "methodName" : "prepareAndExecuteOperation",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.ComponentMessageProcessor",
            "nativeMethod" : false,
            "lineNumber" : 828
          }, {
            "fileName" : "ComponentMessageProcessor.java",
            "methodName" : "access$100",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.ComponentMessageProcessor",
            "nativeMethod" : false,
            "lineNumber" : 192
          }, {
            "fileName" : "ComponentMessageProcessor.java",
            "methodName" : "lambda$innerEventDispatcher$6",
            "className" : "org.mule.runtime.module.extension.internal.runtime.operation.ComponentMessageProcessor$4",
            "nativeMethod" : false,
            "lineNumber" : 685
          }, {
            "fileName" : "FluxPeekFuseable.java",
            "methodName" : "onNext",
            "className" : "reactor.core.publisher.FluxPeekFuseable$PeekConditionalSubscriber",
            "nativeMethod" : false,
            "lineNumber" : 840
          }, {
            "fileName" : "FluxPeekFuseable.java",
            "methodName" : "onNext",
            "className" : "reactor.core.publisher.FluxPeekFuseable$PeekConditionalSubscriber",
            "nativeMethod" : false,
            "lineNumber" : 854
          }, {
            "fileName" : "FluxSubscribeOnValue.java",
            "methodName" : "run",
            "className" : "reactor.core.publisher.FluxSubscribeOnValue$ScheduledScalar",
            "nativeMethod" : false,
            "lineNumber" : 181
          }, {
            "fileName" : "SchedulerTask.java",
            "methodName" : "call",
            "className" : "reactor.core.scheduler.SchedulerTask",
            "nativeMethod" : false,
            "lineNumber" : 68
          }, {
            "fileName" : "SchedulerTask.java",
            "methodName" : "call",
            "className" : "reactor.core.scheduler.SchedulerTask",
            "nativeMethod" : false,
            "lineNumber" : 28
          }, {
            "fileName" : "FutureTask.java",
            "methodName" : "run",
            "className" : "java.util.concurrent.FutureTask",
            "nativeMethod" : false,
            "lineNumber" : 266
          }, {
            "fileName" : "AbstractRunnableFutureDecorator.java",
            "methodName" : "doRun",
            "className" : "org.mule.service.scheduler.internal.AbstractRunnableFutureDecorator",
            "nativeMethod" : false,
            "lineNumber" : 180
          }, {
            "fileName" : "RunnableFutureDecorator.java",
            "methodName" : "run",
            "className" : "org.mule.service.scheduler.internal.RunnableFutureDecorator",
            "nativeMethod" : false,
            "lineNumber" : 55
          }, {
            "fileName" : "ThreadPoolExecutor.java",
            "methodName" : "runWorker",
            "className" : "java.util.concurrent.ThreadPoolExecutor",
            "nativeMethod" : false,
            "lineNumber" : 1149
          }, {
            "fileName" : "ThreadPoolExecutor.java",
            "methodName" : "run",
            "className" : "java.util.concurrent.ThreadPoolExecutor$Worker",
            "nativeMethod" : false,
            "lineNumber" : 624
          }, {
            "fileName" : "Thread.java",
            "methodName" : "run",
            "className" : "java.lang.Thread",
            "nativeMethod" : false,
            "lineNumber" : 750
          } ],
          "suppressed" : [ ]
        },
        "message" : "Fulfillment Order ID: id value of incorrect type: 0a3VF0000002eXdYAIe",
        "payload" : {
          "success" : false,
          "id" : null,
          "errors" : [ {
            "duplicateResult" : null,
            "message" : "Fulfillment Order ID: id value of incorrect type: 0a3VF0000002eXdYAIe",
            "fields" : [ "Id" ],
            "statusCode" : "MALFORMED_ID"
          } ]
        },
        "id" : null,
        "statusCode" : "MALFORMED_ID",
        "successful" : false
      } ],
      "successful" : false
    }
  },
  "applicationName" : "msi-sfdc-sys",
  "applicationVersion" : "local",
  "environment" : "Local",
  "threadName" : "[MuleRuntime].uber.01: [msi-sfdc-sys].patch-fulfillmentOrder-req.BLOCKING @1dc7746a"
}