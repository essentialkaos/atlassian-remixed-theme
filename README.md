<p align="center"><a href="#readme"><img src="https://gh.kaos.st/remixed-theme.svg"/></a></p>

### Installation

#### JIRA

1. Using jira administator account go to `http://your.jira.url/secure/admin/EditAnnouncementBanner!default.jspa`
2. Add this code as first line of announcement:
```html
<link href="//remixed.kaos.st/jira.css" rel="stylesheet" type="text/css" />
```
3. If you don't have any announcement text add this code to announcement:
```html
<link href="//remixed.kaos.st/jira-hide.css" rel="stylesheet" type="text/css" />
```
4. Save announcement;

#### Confluence

1. Go to Space Tools → Look and Feel → Stylesheet
2. Add this code to space stylesheet:
```css
@import url("//remixed.kaos.st/confluence.css");
```

#### Bitbucket Server

1. Stop Bitbucket Server;
2. Add next line to `headContent` param in `app/static/bitbucket/internal/layout/chromeless.soy` and `app/static/bitbucket/internal/layout/base/base.soy` templates after favicon definition;

```html
<link type="text/css" rel="stylesheet" href="https://remixed.kaos.st/bitbucket.css" />
```

i.e., the first 3 lines of `headContent` param in your templates should look like this:

```
        {param headContent}
            <link rel="shortcut icon" href="{plugin_resource('com.atlassian.bitbucket.server.bitbucket-webpack-INTERNAL:favicon', 'favicon.ico')}" />
            <link type="text/css" rel="stylesheet" href="https://remixed.kaos.st/bitbucket.css" />
```

3. Start Bitbucket Server.

### License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)

<p align="center"><a href="https://essentialkaos.com"><img src="https://gh.kaos.st/ekgh.svg"/></a></p>
