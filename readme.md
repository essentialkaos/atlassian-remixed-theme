## Remixed Theme for Atlassian products by EK

### Installing

###### JIRA

1. Copy `styles/jira.css` and `styles/jira-hide.css` to directory `jira-install-dir/atlassian-jira/static-assets`
2. Using jira administator account go to `http://your.jira.url/secure/admin/EditAnnouncementBanner!default.jspa`
3. Add this code in first line of announcement:
```
<link href="//your.jira.url/static-assets/jira.css" rel="stylesheet" type="text/css" />
```
4. If you don't have any announcement text add this code to announcement:
```
<link href="//your.jira.url/static-assets/jira-hide.css" rel="stylesheet" type="text/css" />
```
