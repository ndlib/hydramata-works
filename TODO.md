# Todo

This is a non-exhaustive scratch pad for TODO items.

## Top Level Features

These features reflect the movement of data from one layer to another.
In each layer, there is a concept of a Work and its data structure.

- [ ] Solr -> Memory
- [ ] Memory -> Fedora
- [ ] Memory -> Solr
- [x] UI Input for Edit -> Memory
- [x] Fedora -> Memory
- [x] Memory -> Show HTML
- [x] Memory -> Show JSON
- [x] Memory -> Edit HTML
- [x] Database -> Memory
- [x] Memory -> Database
- [x] Memory -> New HTML
- [x] UI Input for New -> Memory
- [x] Validation in Memory Object

## File Attachments

- [ ] Attachment Presenter - maybe?
- [X] End to End Attachment Test
- [X] Tidy up Attachment Parser

## Low Level Tasks

These should not be considered exhaustive.
But are instead a parking lot that may be cleared or added to.

- [X] Disambigutate identity vs. name for application usage
- [ ] Tidy up validation services; Presently it has lots of knowledge of Work's structure
- [X] Reify an object from persistence then apply value changes
- [ ] Review view rendering path options; Presently the top level work type is created.
- [ ] dom_class should derive from system symbol for identifier
- [ ] dom_class should accept prefix and suffix
- [ ] When persisting Validations make sure to validate that the serialized document is valid
- [X] Setting a predicate by identity or name_for_application_usage should be the same! These are surrogates for each other.
- [ ] Explore the meaning of the variants attribute for Rendering http://api.rubyonrails.org/classes/ActionDispatch/Http/MimeNegotiation.html#method-i-variant-3D
- [X] Look to leveraging Autoload at the Engine level. In doing this all files will be loaded and any dependencies won't invalidate the cache (https://charlie.bz/blog/things-that-clear-rubys-method-cache)
- [ ] Can we have closures for Datastreams. Instead of requesting each datastream and its contents, maybe request the list and hold the references in memory?
- [X] Default work rendering to include work_type as one of the partial
      prefixes.
- [X] Default fieldset rendering to include work_type and fieldset name as the
      partial prefixes.
- [X] Default fieldset rendering to include work_type, fieldset name, and
      predicate name as the partial prefixes.
- [X] Create Work Type persistence
- [X] Create Work Type conversion
- [X] Create Work Type presentation structure persistence
- [X] Integrate presentation structure persistence with construction of in memory objects for presentation
- [X] Remove some duplication of Work Type and Predicate (moving towards a Definition concept?)
- [X] Create some rudimentary seeds for Work Types
- [X] Create some rudimentary seeds for Work Types presentation structure
- [X] Create some rudimentary seeds for Predicates
- [X] Allow for the declaration of validations for a given Predicate
- [X] Improve internationalization support by providing a better key path.
- [X] Add view tests for show templates
- [X] Add view tests for edit templates
- [X] Add view tests for new templates
- [X] Add PresentationStructure builder by WorkType; This is done by interrogating the
      data storage.
- [X] Add support for multi rails
- [X] itemtype for WorkType presenter (RDFa and Microdata)
- [X] Conversion for Work to WorkPresenter; Or Presenter() conversion
- [X] Create a NullWorkType concept.
      It would be helpful to create a Null Work Type, so our application doesn't choke.
- [X] Add internationalization for Work Type contexts:
  - [X] Work type name
  - [X] Work type description
  - [X] Work type verbose description (fallback to description)
- [X] Add internationalization for Predicate Set
  - [X] Predicate set name
  - [X] Predicate set description
  - [X] Predicate set verbose description (fallback to description)
- [X] Add internationalization for Predicate
  - [X] Predicate label
  - [X] Predicate description (hint)
  - [X] Predicate verbose description (fallback to description)