### About

A Jekyll plugin to create a multilanguage dictionary from a data file.

### Configuration

Example of required configuration in `_config.yml`:

```
dictionary:
  prefix: /dictionary
  languages:
    - vn
	- en
```

Localize strings in `_data/i18n.json`, for example, to localize the names of each of the above languages as they will appear on the entries pages:

```
{
	"vn": {
		"vn": "Tiếng Việt",
		"en": "Vietnamese"
	},
	"en": {
		"vn": "Tiếng Anh",
		"en": "English"
	},
	...
```

Dictionary entries are stored in `_data/dictionary.json`:

```
[
	{
		"vn": "bị",
		"pos": "v",
		"definition": {
			"en": "Unfavorable passive voice",
			"zh": "被"
		},
		"examples": [
			{
				"text": {
					"vn": "bị phạt",
					"en": "to be fined/punished",
					"zh": "..."
				}
				"context": {
					"en": "...",
					"zh": "..."
				}
				"explanation": {
					"en": "...",
					"zh": "..."
				}
			}
		]
	}
]
```
