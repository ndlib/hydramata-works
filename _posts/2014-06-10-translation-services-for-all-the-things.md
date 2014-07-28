---
author:   jeremyf
category: demos
filename: 2014-06-10-translation-services-for-all-the-things.md
layout:   demo
title:    Translation Services for All the Things
tags:     demo, rails, i18n
---

## Introduction to Rails Translation Services

[Rails provides robust support for internationalization](http://guides.rubyonrails.org/i18n.html).

This includes:

* View lookups - when rendering a show page, pick the appropriate template based on language
* Routes - maybe you want to resolve the /katalog route to the Catalog controller for your Danish friends?
* Times and Dates - because we can't all be ISO compliant
* Model errors - maybe you want different language when an attribute is not present?
* Model attributes - because sometimes your model's name isn't human readable, or its attributes

## Example

Given that [I've taken the time to allow for custom view rendering](../view-lookup-for-work-type-predicate-set-and-predicate), I need a similar way to make sure each Work Type, Fieldset, and Property's labels, hints, etc. are flexible.
This is handled by [Hydramata::Works::Translator]({{ site.repo_url_file_prefix }}/lib/hydramata/works/translator.rb).

This again uses the idea of diminishing specificity.
After all most of the time the "hint" for a work's DC:Title predicate will be the same regardless of the work type.

But in some cases when the DC:Title hint varies, the Translator is there to help.

Below is an example translation file.

If you had a generic work type and were to render a DC:Title field, the label would render as "The title of your work".
However, if the work type was an Article, the label would be "The title of your Article".
In both cases, the hint would be "The short yet descriptive title of your work".

```yaml
en:
  hydramata:
    work:
      works:
        article:
          name: Article
          fieldsets:
            required:
              description: These fields are required for all Articles.
          properties:
            dc_title:
              label: The title of your Article
      fieldsets:
        required:
          name: Required
          description: These fields are required
      properties:
        dc_title:
          name: Title
          label: The title of your work
          hint: The short yet descriptive title of your work
```

## Supporting Specs

The gory details of the Internationalization is asserted in the [Translation Services spec]({{ site.repo_url_file_prefix }}/spec/features/translation_services_spec.rb)