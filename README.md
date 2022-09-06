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
4. Save announcement.
5. Add this lines to Jira Editor plugin styles:
- `jira-editor-plugin-*.jar:/vendor/tinymce/skins/content/dark/content.min.css`
- `jira-editor-plugin-*.jar:/vendor/tinymce/skins/content/default/content.min.css`
- `jira-editor-plugin-*.jar:/vendor/tinymce/skins/content/document/content.min.css`
- `jira-editor-plugin-*.jar:/vendor/tinymce/skins/content/writer/content.min.css`
```css
@import url("//remixed.kaos.st/jira.css");
```

#### Confluence

1. Go to Space Tools → Look and Feel → Stylesheet.
2. Add this code to space stylesheet:
```css
@import url("//remixed.kaos.st/confluence.css");
```

### License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0)

<p align="center"><a href="https://essentialkaos.com"><img src="https://gh.kaos.st/ekgh.svg"/></a></p>
