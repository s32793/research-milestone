#set document(title: "Research part - milestone")
#set heading(numbering: "1.1")

#outline(title: [Table of contents])
#outline(title: [List of figures], target: figure.where(kind: image))

#pagebreak()

#include "sections/1-intro.typ"
#include "sections/2-research-methods.typ"
#include "sections/3-similar-solutions.typ"
#include "sections/4-similar-theses.typ"

#bibliography("refs.bib", style: "ieee")  