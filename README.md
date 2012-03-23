CleanMyHtml
===========

Simple JavaScript library facilitating semantic HTML markup.

Why do you want it?
------------------

Consider you have this HTML:

```html
<body>
  <sidebar>
    Lorem Ipsum
    ...
  </sidebar>
  <section>
    Dolor Sit Amet.
    ...
  </section>
</body>
```

And you want both `<section>` and `<sidebar>` to be rounded with a border.
You don't want to specify styles like this:

```css
sidebar, section {
  border-radius: 1px;
  border: 1px solid black;
}
```

Because you are likely to have another rounded element sooner or later.
So you define it like:

```css
.rounded-box {
  ...
}
```

And in your HTML:

```html
  <sidebar class="rounded-box">...</sidebar>
  <section class="rounded-box">...</section>
```

The problem is – `class="rounded-box"` is not about content, it's about presentation.

With CleanMyHtml you can deal with it the other way:

```html
<head>
  <script type="text/clean_html" encoding="utf-8" src="CleanMyHtml.cmh"></script>
  <script type="text/javascript" encoding="utf-8" src="CleanMyHtml.js"></script>
</head>
<body>
  <sidebar>
    Lorem Ipsum
    ...
  </sidebar>
  <section id="main-section">
    Dolor Sit Amet.
    ...
  </section>
</body>
```

And in your __CleanMyHtml.cmh__:

```
#main-section, sidebar {
  .rounded-box;
  .thick-border;
  ...
}

#main-section {
  .light-background;
}
```

And it will add needed css classes to the html automatically, resulting in more readable and
maintainable source html!

Caveats:
--------

At this moment it works with dynamically elements only if you call $(element).trigger('create')

Development dependencies:
-------------------------

* Node.js >= 0.6.12
* npm >= 1.1.4

How to develop:
---------------

```
$ npm install
$ ./run spec #or ./run spec --autotest
$ ./run compile #or ./run compile --watch
```
