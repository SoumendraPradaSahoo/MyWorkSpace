$(document).ready(function() {var formatter = new CucumberHTML.DOMFormatter($('.cucumber-report'));formatter.uri("Feature/MyFeature.feature");
formatter.feature({
  "name": "Test Search for Google",
  "description": "",
  "keyword": "Feature"
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
  "keyword": "Scenario",
  "tags": [
    {
      "name": "@SmokeTest"
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
  "name": "Search \"Pritam\"",
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