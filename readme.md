## Remixed Theme for Atlassian products by EK

### Usage

#### JIRA

* Using jira administator account go to `http://your.jira.url/secure/admin/EditAnnouncementBanner!default.jspa`
* Add this code as first line of announcement:
```html
<link href="//remixed.kaos.st/jira.css" rel="stylesheet" type="text/css" />
```
* If you don't have any announcement text add this code to announcement:
```html
<link href="//remixed.kaos.st/jira-hide.css" rel="stylesheet" type="text/css" />
```
* Save announcement

#### Confluence

* Go to Space Tools → Look and Feel → Stylesheet
* Add this code to space stylesheet:
```css
@import url("//remixed.kaos.st/confluence.css");
```
