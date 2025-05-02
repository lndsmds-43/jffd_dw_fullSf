<?xml version="1.0" encoding="UTF-8"?>

<mule xmlns:http="http://www.mulesoft.org/schema/mule/http" xmlns:ee="http://www.mulesoft.org/schema/mule/ee/core"
	xmlns="http://www.mulesoft.org/schema/mule/core"
	xmlns:doc="http://www.mulesoft.org/schema/mule/documentation" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.mulesoft.org/schema/mule/core http://www.mulesoft.org/schema/mule/core/current/mule.xsd
http://www.mulesoft.org/schema/mule/ee/core http://www.mulesoft.org/schema/mule/ee/core/current/mule-ee.xsd
http://www.mulesoft.org/schema/mule/http http://www.mulesoft.org/schema/mule/http/current/mule-http.xsd">
	<flow name="sfToNs-orderSync-controller" doc:id="7335b170-e37f-4171-9287-3e3250da8eb7" >
		<ee:transform doc:name="Transform Message" doc:id="acea67a8-7694-482b-af3d-48779fc341a6" >
			<ee:message >
				<ee:set-payload ><![CDATA[%dw 2.0
output application/java
---
{
}]]></ee:set-payload>
			</ee:message>
		</ee:transform>
	</flow>
	<flow name="sfToNs-orders-build-purchaseOrder" doc:id="0b55e657-fe73-4531-a2b6-bb5727d67eb5" >
		<ee:transform doc:name="Transform Message" doc:id="94343c0f-8053-49e1-8526-34f3021af8ea" >
			<ee:message >
				<ee:set-payload ><![CDATA[%dw 2.0
output application/java
---
{
}]]></ee:set-payload>
			</ee:message>
		</ee:transform>
	</flow>
	<flow name="sfToNs-orders-build-nsSalesOrder" doc:id="c7c10d3f-cd2d-4df4-b3ca-4116950d3f37" >
		<logger level="INFO" doc:name="Logger" doc:id="26102b0b-b7a4-4970-bae1-12edee5a8123" />
	</flow>
	<flow name="sfToNs-orders-send-nsSalesOrder" doc:id="ee74eea4-ce83-4a84-bc08-f547fafda3c7">
		<logger level="INFO" doc:name="Logger" doc:id="c920fe7e-cbae-4152-a694-892c19ab3689" />
	</flow>
	<flow name="sfToNs-orders-build-nsFulfillmentRequest" doc:id="bb7a5296-4646-4cd2-9e60-fab0a36ae1e7" >
		<logger level="INFO" doc:name="Logger" doc:id="b8d641ab-1c48-4888-bb5a-7cd0b6ce1498" />
	</flow>
	<flow name="sfToNs-orders-send-nsFulfillmentRequest" doc:id="47e6fc0e-20c0-40fa-82db-c72d0d7dc8b8" >
		<logger level="INFO" doc:name="Logger" doc:id="db29e054-3177-47de-a39c-9d66ac66f9b9" />
	</flow>
	<flow name="sfToNs-orders-build-nsCustomerDeposit" doc:id="a0389d1e-95cb-47ca-9210-8598d932318b" >
		<logger level="INFO" doc:name="Logger" doc:id="5a450bdf-6311-452d-a7c5-92584934e527" />
	</flow>
	<flow name="sfToNs-orders-send-nsCustomerDeposit" doc:id="39a84731-e860-43b4-b89a-154d56c9ee9f">
		<logger level="INFO" doc:name="Logger" doc:id="13e6fce8-71de-4f40-a12e-b1d8b1e7b33b" />
	</flow>
</mule>
