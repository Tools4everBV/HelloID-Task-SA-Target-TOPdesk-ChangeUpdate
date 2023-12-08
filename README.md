# HelloID-Task-SA-Target-TOPdesk-ChangeUpdate

## Prerequisites

- [ ] TOPdesk API Username and Key
- [ ] User-defined variables: `topdeskBaseUrl`, `topdeskApiUsername` and `topdeskApiSecret` created in your HelloID portal.

## Description

This code snippet will update an change within TOPdesk and executes the following tasks:

1. Define a hash table `$formObject`. The keys of the hash table represent the properties necessary to update an change within `TOPdesk`, while the values represent the values entered in the form.

> To view an example of the form output, please refer to the JSON code pasted below.

```json
{
    "id": "dfa38bc0-5ca6-4222-8cbe-8ab071c58f9d",
    "updates": [
        {
            "op": "replace",
            "path": "/briefDescription",
            "value": "Change example - updated"
        },
        {
            "op": "replace",
            "path": "/externalNumber",
            "value": "12345678"
        },
        {
            "op": "remove",
            "path": "/subcategory"
        }
    ]
}
```

> :exclamation: It is important to note that the names of your form fields might differ. Ensure that the `$formObject` hash table is appropriately adjusted to match your form fields.
> [See the TOPdesk API Docs page](https://developers.topdesk.com/explorer/?page=change#/Working%20as%20an%20operator/patch_operatorChanges__identifier_)

2. Creates authorization headers using the provided API key and secret.

3. Update an change using the: `Invoke-RestMethod` cmdlet. The hash table called: `$formObject` is passed to the body of the: `Invoke-RestMethod` cmdlet as a JSON object.