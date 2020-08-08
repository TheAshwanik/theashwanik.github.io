---
layout: post
title: "Convert Swagger or OpenAPI Specs to Spring Boot REST API"
description: "Convert Swagger or OpenAPI Specs to Spring Boot REST API"
date_formatted: 2020-08-06 17:10
date: 2020-08-06
comments: true
categories: [Technical]
tags: swagger, openapi, springboot, spring
keywords: swagger, openapi, springboot, spring
---

What is Swagger?
Swagger allows you to describe the structure of your APIs so that machines can read them. The ability of APIs to describe their own structure is the root of all awesomeness in Swagger.

1.  Open https://editor.swagger.io/
2.  Select File -> Import URL
3.  Enter any of these URL and you would be able to see compelete spec in a clearly understandable format.<!--more-->    
	[API ServiceOrdering 4.0.0](https://raw.githubusercontent.com/tmforum-apis/TMF641_ServiceOrder/master/TMF641-Service_Ordering-v4.0.0.swagger.json)  [ Base URL: serverRoot/tmf-api/serviceOrdering/v4 ]    
	[Federated ID 4.0](https://raw.githubusercontent.com/tmforum-apis/TMF691_FederatedIdentity/master/TMF691-FederatedIdentity-v4.0.0.swagger.json) [ Base URL: serverRoot/tmf-api/openid/v4 ]     
	[Communication Management API 4.0.0](https://raw.githubusercontent.com/tmforum-apis/TMF681_Communication/master/TMF681-Communication-v4.0.0.swagger.json) [ Base URL: serverRoot/tmf-api/communicationManagement/v4/ ]   


You would notice how OpenAPI/Swagger Specification helps understand the API and agree on its attributes. 
In this post I am going to show how we can generate code and documentation from the specification file.

Let's generate the code create an empty maven project named "TMF-ApiSpec"   

There are several ways to generate the code from a swagger json/yaml spec.    
For e.g. You can download [openapi-generator-cli-4.2.3.jar](https://openapi-generator.tech/docs/installation/#jar) and use the generate command.    

{% codeblock %}
java -cp . -jar openapi-generator-cli-4.2.3.jar generate -i TMF641-ServiceOrdering-3.0.0.swagger.json --api-package com.cts.serviceorder.client.api --model-package com.cts.serviceorder.client.model --invoker-package com.cts.serviceorder.client.invoker --group-id com.cts --artifact-id spring-openapi-generator-api-client --artifact-version 0.0.1-SNAPSHOT -g java -p java8=true --library resttemplate -o openapi-serviceorder
{% endcodeblock %}

See more about [generate](https://openapi-generator.tech/docs/usage#generate) and  [help](https://openapi-generator.tech/docs/usage#help)    

You can also use online service to generate the code:    

{% codeblock %}
curl -X POST -H "content-type:application/json" -d '{"openAPIUrl":"https://github.com/tmforum-apis/TMF641_ServiceOrder/releases/download/v3.0.0/TMF641-ServiceOrdering-3.0.0.swagger.json"}' http://api.openapi-generator.tech/api/gen/clients/java
{% endcodeblock %}

I am using the [plugin](https://openapi-generator.tech/docs/plugins)       

For the API spec I am using TMForum's ServiceOrderingManagement OpenAPI specification.
You can choose one of [Yaml](https://raw.githubusercontent.com/tmforum-rand/RI-TMF641-ServiceOrderingManagement-R18-5/master/api/swagger.yaml) or [Json format](https://raw.githubusercontent.com/tmforum-apis/TMF641_ServiceOrder/master/TMF641-Service_Ordering-v4.0.0.swagger.json)

#### Update the pom.xml File:

{% codeblock %} 
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.ashwani</groupId>
  <artifactId>TMF-ApiSpec</artifactId>
  <version>0.0.1-SNAPSHOT</version>
 
    <properties>
        <swagger-annotations-version>1.5.22</swagger-annotations-version>
        <jersey-version>2.27</jersey-version>
        <jackson-version>2.8.9</jackson-version>
        <jodatime-version>2.7</jodatime-version>
        <maven-plugin-version>1.0.0</maven-plugin-version>
        <junit-version>4.8.1</junit-version>
        <springfox-version>2.9.2</springfox-version>
        <threetenbp-version>1.3.8</threetenbp-version>
        <datatype-threetenbp-version>2.6.4</datatype-threetenbp-version>
        <spring-boot-starter-test-version>2.1.1.RELEASE</spring-boot-starter-test-version>
        <spring-boot-starter-web-version>2.1.0.RELEASE</spring-boot-starter-web-version>
        <junit-version>4.12</junit-version>
        <migbase64-version>2.2</migbase64-version>
    </properties>
 
    <dependencies>
        <dependency>
            <groupId>io.swagger</groupId>
            <artifactId>swagger-annotations</artifactId>
            <version>${swagger-annotations-version}</version>
        </dependency>
        <dependency>
            <groupId>org.glassfish.jersey.core</groupId>
            <artifactId>jersey-client</artifactId>
            <version>${jersey-version}</version>
        </dependency>
        <dependency>
            <groupId>org.glassfish.jersey.media</groupId>
            <artifactId>jersey-media-multipart</artifactId>
            <version>${jersey-version}</version>
        </dependency>
        <dependency>
            <groupId>org.glassfish.jersey.media</groupId>
            <artifactId>jersey-media-json-jackson</artifactId>
            <version>${jersey-version}</version>
        </dependency>
        <dependency>
            <groupId>com.fasterxml.jackson.jaxrs</groupId>
            <artifactId>jackson-jaxrs-base</artifactId>
            <version>${jackson-version}</version>
        </dependency>
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-core</artifactId>
            <version>${jackson-version}</version>
        </dependency>
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-annotations</artifactId>
            <version>${jackson-version}</version>
        </dependency>
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>${jackson-version}</version>
        </dependency>
        <dependency>
            <groupId>com.fasterxml.jackson.jaxrs</groupId>
            <artifactId>jackson-jaxrs-json-provider</artifactId>
            <version>${jackson-version}</version>
        </dependency>
        <dependency>
            <groupId>com.fasterxml.jackson.datatype</groupId>
            <artifactId>jackson-datatype-joda</artifactId>
            <version>${jackson-version}</version>
        </dependency>
        <dependency>
            <groupId>joda-time</groupId>
            <artifactId>joda-time</artifactId>
            <version>${jodatime-version}</version>
        </dependency>
        <dependency>
            <groupId>com.brsanthu</groupId>
            <artifactId>migbase64</artifactId>
            <version>${migbase64-version}</version>
        </dependency>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>${junit-version}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <version>${spring-boot-starter-test-version}</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
            <version>${spring-boot-starter-web-version}</version>
        </dependency>
        <dependency>
            <groupId>io.springfox</groupId>
            <artifactId>springfox-swagger2</artifactId>
            <version>${springfox-version}</version>
        </dependency>
        <dependency>
            <groupId>io.springfox</groupId>
            <artifactId>springfox-swagger-ui</artifactId>
            <version>${springfox-version}</version>
        </dependency>
        <dependency>
            <groupId>org.threeten</groupId>
            <artifactId>threetenbp</artifactId>
            <version>${threetenbp-version}</version>
        </dependency>
        <dependency>
            <groupId>com.github.joschi.jackson</groupId>
            <artifactId>jackson-datatype-threetenbp</artifactId>
            <version>${datatype-threetenbp-version}</version>
        </dependency>
    </dependencies>
 
    <build>
        <plugins>
            <plugin>
                <groupId>org.openapitools</groupId>
                <artifactId>openapi-generator-maven-plugin</artifactId>
                <version>3.3.4</version>
                <executions>
                    <execution>
                        <id>spring-boot-api</id>
                        <goals>
                            <goal>generate</goal>
                        </goals>
                        <configuration>
                            <inputSpec>${project.basedir}/src/main/resources/TMF641-Service_Ordering-v4.0.0.swagger.json</inputSpec>
                            <generatorName>spring</generatorName>
                            <configOptions>
                                <dateLibrary>joda</dateLibrary>
                            </configOptions>
                            <library>spring-boot</library>
                            <apiPackage>com.ashwani.demo.api</apiPackage>
                            <modelPackage>com.ashwani.demo.api.model</modelPackage>
                            <invokerPackage>com.ashwani.demo.api.handler</invokerPackage>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.6.1</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                </configuration>
            </plugin>
            <plugin>
                <artifactId>maven-deploy-plugin</artifactId>
                <version>2.8.1</version>
                <executions>
                    <execution>
                        <id>default-deploy</id>
                        <phase>deploy</phase>
                        <goals>
                            <goal>deploy</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>
{% endcodeblock %}
Execute MVN install in the root directory of the project. 
And the resulting code would be generated by openapi-generator-maven-plugin in target/generated-sources/. com.ashwani.demo.api. 
[Various generators](https://github.com/OpenAPITools/openapi-generator/tree/master/docs/generators) based on your preference.

Now let's create a new spring boot project demo-service from  [https://start.spring.io/](https://start.spring.io/).
Once a bare spring boot project is created with Spring Web dependency. 
Now add the Maven dependency in this spring project.

{% codeblock %}
		
		<dependency>
	    	<groupId>com.ashwani</groupId>
	    	<artifactId>openapi-serviceorder-client</artifactId>
		  	<version>0.0.1-SNAPSHOT</version>
		  	<scope>system</scope>
		 	<systemPath>${basedir}/lib/openapi-serviceorder-client-0.0.1-SNAPSHOT.jar</systemPath>
		</dependency>
		
		
{% endcodeblock %}

Now create a class ServiceOrderApiController which will implement previously generated ServiceOrderApi from previous step. And make some implementation of the API:

{% codeblock %}
package com.ashwani.serviceorder.api;

import java.security.Principal;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.threeten.bp.OffsetDateTime;

import com.ashwani.serviceorder.api.model.Error;
import com.ashwani.serviceorder.api.model.RelatedParty;
import com.ashwani.serviceorder.api.model.ServiceOrder;
import com.ashwani.serviceorder.api.model.ServiceOrderCreate;
import com.ashwani.serviceorder.api.model.ServiceOrderItem;
import com.ashwani.serviceorder.api.model.ServiceRestriction;
import com.ashwani.serviceorder.api.ServiceOrderRepoService;


import com.fasterxml.jackson.databind.ObjectMapper;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;

@javax.annotation.Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2020-07-25T00:30:31.539259300+01:00[Europe/London]")

@Controller
@RequestMapping("${openapi.aPIServiceOrdering.base-path:/tmf-api/serviceOrdering/v3}")
public class ServiceOrderApiController implements ServiceOrderApi {

	private static final Logger logger = LoggerFactory.getLogger(ServiceOrderApiController.class);

	private final ObjectMapper objectMapper;

	private final HttpServletRequest request;
	
	@Autowired
	ServiceOrderRepoService serviceOrderRepoService;

	
    @Autowired
	public ServiceOrderApiController(ObjectMapper objectMapper, HttpServletRequest request) {
		this.objectMapper = objectMapper;
		this.request = request;
	}

    @ApiOperation(value = "Creates a ServiceOrder", nickname = "createServiceOrder", notes = "This operation creates a ServiceOrder entity.", response = ServiceOrder.class, tags={ "serviceOrder", })
    @ApiResponses(value = { 
        @ApiResponse(code = 201, message = "Created", response = ServiceOrder.class),
        @ApiResponse(code = 400, message = "Bad Request", response = Error.class),
        @ApiResponse(code = 401, message = "Unauthorized", response = Error.class),
        @ApiResponse(code = 403, message = "Forbidden", response = Error.class),
        @ApiResponse(code = 405, message = "Method Not allowed", response = Error.class),
        @ApiResponse(code = 409, message = "Conflict", response = Error.class),
        @ApiResponse(code = 500, message = "Internal Server Error", response = Error.class) })
    @RequestMapping(value = "/serviceOrder",
        produces = { "application/json;charset=utf-8" }, 
        consumes = { "application/json;charset=utf-8" },
        method = RequestMethod.POST)
    public ResponseEntity<ServiceOrder> createServiceOrder(@ApiParam(value = "The ServiceOrder to be created" ,required=true )  @Valid @RequestBody ServiceOrderCreate serviceOrderCreate) {
        ServiceOrderCreate soc = serviceOrderCreate;
        
            try {
		          	System.out.println(serviceOrderCreate.toString());
				    ServiceOrder c = serviceOrderRepoService.addServiceOrder(soc);
					return new ResponseEntity<ServiceOrder>(c, HttpStatus.OK);				

		    }catch (Exception e) {
				e.printStackTrace();
				return new ResponseEntity<ServiceOrder>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
    }
}
{% endcodeblock %}
{% codeblock %}
package com.ashwani.serviceorder.api;


import java.util.Date;
import java.util.Set;

import javax.validation.Valid;

import org.joda.time.DateTime;
import org.springframework.stereotype.Service;
import org.threeten.bp.OffsetDateTime;
import org.threeten.bp.ZoneOffset;

import com.ashwani.serviceorder.api.model.Any;
import com.ashwani.serviceorder.api.model.Characteristic;
import com.ashwani.serviceorder.api.model.ServiceOrder;
import com.ashwani.serviceorder.api.model.ServiceOrderAttributeValueChangeEvent;
import com.ashwani.serviceorder.api.model.ServiceOrderAttributeValueChangeNotification;
import com.ashwani.serviceorder.api.model.ServiceOrderCreate;
import com.ashwani.serviceorder.api.model.ServiceOrderItem;
import com.ashwani.serviceorder.api.model.ServiceOrderStateChangeEvent;
import com.ashwani.serviceorder.api.model.ServiceOrderStateChangeNotification;
import com.ashwani.serviceorder.api.model.ServiceOrderStateType;

@Service
public class ServiceOrderRepoService {

	public ServiceOrder addServiceOrder(@Valid ServiceOrderCreate serviceOrderCreate) {
		ServiceOrder so = new ServiceOrder();
		DateTime d = DateTime.now();
		so.setOrderDate(d);
		so.setCategory(serviceOrderCreate.getCategory());
		so.setDescription(serviceOrderCreate.getDescription());
		so.setExternalId(serviceOrderCreate.getExternalId());
		so.setNotificationContact(serviceOrderCreate.getNotificationContact());
		so.priority(serviceOrderCreate.getPriority());
		so.requestedCompletionDate(serviceOrderCreate.getRequestedCompletionDate());
		so.requestedStartDate(serviceOrderCreate.getRequestedStartDate());
		so.setExpectedCompletionDate(serviceOrderCreate.getRequestedCompletionDate()); // this is by default
		if (serviceOrderCreate.getNote() != null) {
			so.getNote().addAll(serviceOrderCreate.getNote());
		}

		boolean allAcknowledged = true;
		if (serviceOrderCreate.getOrderItem() != null) {
			so.getOrderItem().addAll(serviceOrderCreate.getOrderItem());
			for (ServiceOrderItem soi : so.getOrderItem()) {
//				copySpecCharacteristicsToServiceCharacteristic(soi.getService().getServiceSpecification().getId(),
//						soi.getService().getServiceCharacteristic());
//				
				System.out.println("SOI --> " + soi.toString());
				
				if (soi.getState()!= null && !soi.getState().equals(ServiceOrderStateType.ACKNOWLEDGED)) {
					allAcknowledged = false;
				}
			}

		}

		if (serviceOrderCreate.getRelatedParty() != null) {
			so.getRelatedParty().addAll(serviceOrderCreate.getRelatedParty());
		}
		if (serviceOrderCreate.getOrderRelationship() != null) {
			so.getOrderRelationship().addAll(serviceOrderCreate.getOrderRelationship());

		}


		// so = this.serviceOrderRepo.save(so);  You can save this in DB.

		if (allAcknowledged) { // in the case were order items are automatically acknowledged
			so.setState(ServiceOrderStateType.ACKNOWLEDGED);
			d = DateTime.now();
			so.setOrderDate(d);
			//so = this.serviceOrderRepo.save(so);
		}

		//raiseSOCreateNotification(so);

		return so;
	}
	
}
{% endcodeblock %}
Now we can test the server.
Send a request from postman on following end point.
http://localhost:8080/tmf-api/serviceOrdering/v3/serviceOrder

If all goes well you will get the following response:
{% codeblock %}
{
    "id": null,
    "href": null,
    "category": "TMF resource illustration",
    "completionDate": null,
    "description": "Service order description",
    "expectedCompletionDate": "2018-01-15T09:37:40.508Z",
    "externalId": "OrangeBSS748",
    "notificationContact": null,
    "orderDate": "2020-08-06T15:51:02.131Z",
    "priority": "1",
    "requestedCompletionDate": "2018-01-15T09:37:40.508Z",
    "requestedStartDate": "2018-01-15T09:37:40.508Z",
    "startDate": null,
    "note": null,
    "orderItem": [
        {
            "id": "1",
            "action": "add",
            "appointment": null,
            "orderItemRelationship": null,
            "service": {
                "id": null,
                "href": null,
                "category": null,
                "name": null,
                "serviceType": null,
                "place": null,
                "relatedParty": null,
                "serviceCharacteristic": null,
                "serviceRelationship": null,
                "serviceSpecification": {
                    "id": "12",
                    "href": "http://...:serviceSpecification/12",
                    "name": "vCPE",
                    "version": "1",
                    "targetServiceSchema": null,
                    "@baseType": null,
                    "@schemaLocation": "http...",
                    "@type": "vCPE",
                    "@referredType": null
                },
                "state": null,
                "supportingResource": null,
                "supportingService": null,
                "@baseType": null,
                "@schemaLocation": null,
                "@type": null
            },
            "state": null,
            "@baseType": null,
            "@schemaLocation": null,
            "@type": "ServiceOrder"
        }
    ],
    "orderRelationship": null,
    "relatedParty": null,
    "state": "acknowledged",
    "@baseType": null,
    "@schemaLocation": null,
    "@type": null
}

{% endcodeblock %}

#### Next steps:
To add persistent to the order creation etc. Something similar to [this](https://github.com/tmforum-rand/RI-TMF641-ServiceOrderingManagement-R18-5)

#### Few References:

[Swagger-codegen/](https://swagger.io/docs/open-source-tools/swagger-codegen/)
[Swagger Editor online](https://editor.swagger.io/)
[TMForum OpenAPI Table](https://projects.tmforum.org/wiki/display/API/Open+API+Table)
[openapi-generator-maven-plugin](https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator-maven-plugin/README.md)
[Swagger UI-Once you generate the code, it also generates a swagger UI](http://localhost:8080/swagger-ui.html/serviceOrder/createServiceOrder)
[openslice](https://github.com/openslice/io.openslice.tmf.web)
[TMForum Datamodel](http://datamodel.tmforum.org/en/latest/)

