// Shared layout for every SmartCooking design document. Import it, don't
// copy it: `#import "template.typ": project`.
#let project(title: "", authors: (), body) = {
  set document(title: title, author: authors)
  set page(margin: (x: 2.5cm, y: 3cm), numbering: "1")
  set text(size: 11pt)
  set heading(numbering: "1.1")

  align(center)[
    #text(17pt, weight: "bold")[#title]
    #if authors.len() > 0 [
      #v(0.5em)
      #text(11pt)[#authors.join(", ")]
    ]
  ]
  v(1.5em)

  body
}
