$(document).ready(function() {var formatter = new CucumberHTML.DOMFormatter($('.cucumber-report'));formatter.uri("Feature/MyFeature.feature");
formatter.feature({
  "name": "Test Search for Google",
  "description": "",
  "keyword": "Feature"
});
formatter.scenarioOutline({
  "name": "Search name in google",
  "description": "",
  "keyword": "Scenario Outline",
  "tags": [
    {
      "name": "@RegressionTest"
    }
  ]
});
formatter.step({
  "name": "Lunch Google in Browser",
  "keyword": "Given "
});
formatter.step({
  "name": "Search \"\u003cSerachParameter\u003e\"",
  "keyword": "When "
});
formatter.step({
  "name": "Click on Search",
  "keyword": "And "
});
formatter.step({
  "name": "Verify Title",
  "keyword": "Then "
});
formatter.step({
  "name": "Close the browser",
  "keyword": "And "
});
formatter.examples({
  "name": "",
  "description": "",
  "keyword": "Examples",
  "rows": [
    {
      "cells": [
        "SerachParameter"
      ]
    },
    {
      "cells": [
        "Soumendra"
      ]
    },
    {
      "cells": [
        "Sanjeev"
      ]
    }
  ]
});
formatter.background({
  "name": "",
  "description": "",
  "keyword": "Background"
});
formatter.step({
  "name": "Open Chrome Browser",
  "keyword": "Given "
});
formatter.match({
  "location": "StepDefination.open_Chrome_Browser()"
});
formatter.result({
  "status": "passed"
});
formatter.scenario({
  "name": "Search name in google",
  "description": "",
  "keyword": "Scenario Outline",
  "tags": [
    {
      "name": "@RegressionTest"
    }
  ]
});
formatter.step({
  "name": "Lunch Google in Browser",
  "keyword": "Given "
});
formatter.match({
  "location": "StepDefination.lunch_Google_in_Browser()"
});
formatter.result({
  "status": "passed"
});
formatter.step({
  "name": "Search \"Soumendra\"",
  "keyword": "When "
});
formatter.match({
  "location": "StepDefination.search(String)"
});
formatter.result({
  "status": "passed"
});
formatter.step({
  "name": "Click on Search",
  "keyword": "And "
});
formatter.match({
  "location": "StepDefination.click_on_Search()"
});
formatter.result({
  "status": "passed"
});
formatter.step({
  "name": "Verify Title",
  "keyword": "Then "
});
formatter.match({
  "location": "StepDefination.verify_Title()"
});
formatter.result({
  "status": "passed"
});
formatter.step({
  "name": "Close the browser",
  "keyword": "And "
});
formatter.match({
  "location": "StepDefination.close_the_browser()"
});
formatter.result({
  "status": "passed"
});
formatter.background({
  "name": "",
  "description": "",
  "keyword": "Background"
});
formatter.step({
  "name": "Open Chrome Browser",
  "keyword": "Given "
});
formatter.match({
  "location": "StepDefination.open_Chrome_Browser()"
});
formatter.result({
  "status": "passed"
});
formatter.scenario({
  "name": "Search name in google",
  "description": "",
  "keyword": "Scenario Outline",
  "tags": [
    {
      "name": "@RegressionTest"
    }
  ]
});
formatter.step({
  "name": "Lunch Google in Browser",
  "keyword": "Given "
});
formatter.match({
  "location": "StepDefination.lunch_Google_in_Browser()"
});
formatter.result({
  "status": "passed"
});
formatter.step({
  "name": "Search \"Sanjeev\"",
  "keyword": "When "
});
formatter.match({
  "location": "StepDefination.search(String)"
});
formatter.result({
  "status": "passed"
});
formatter.step({
  "name": "Click on Search",
  "keyword": "And "
});
formatter.match({
  "location": "StepDefination.click_on_Search()"
});
formatter.result({
  "status": "passed"
});
formatter.step({
  "name": "Verify Title",
  "keyword": "Then "
});
formatter.match({
  "location": "StepDefination.verify_Title()"
});
formatter.result({
  "status": "passed"
});
formatter.step({
  "name": "Close the browser",
  "keyword": "And "
});
formatter.match({
  "location": "StepDefination.close_the_browser()"
});
formatter.result({
  "status": "passed"
});
});