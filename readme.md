## Remixed Theme for Atlassian products by EK

### Installing

###### JIRA

* Copy `styles/jira.css` and `styles/jira-hide.css` to directory `jira-install-dir/atlassian-jira/static-assets`
* Using jira administator account go to `http://your.jira.url/secure/admin/EditAnnouncementBanner!default.jspa`
* Add this code as first line of announcement:
```html
<link href="//your.jira.url/static-assets/jira.css" rel="stylesheet" type="text/css" />
```
* If you don't have any announcement text add this code to announcement:
```html
<link href="//your.jira.url/static-assets/jira-hide.css" rel="stylesheet" type="text/css" />
```
* Save announcement
