#import "template.typ": project

#show: project.with(title: "SmartCooking — Product Vision", authors: ("Vianney Veremme",))

Each product decision below is tagged *Decided* or *Provisional*. A
*Provisional* item is not yet approved by the Owner and must not be treated as
settled by anyone building against this document. The single unresolved
question that shapes the rest of the scope has its own section, below.

= Problem

Beginner cooks and students struggle to cook for themselves, and part of that
struggle is well-evidenced: two independent peer-reviewed surveys of US
undergraduates (n=338 each) found 41-47% reporting food insecurity, with rates
rising sharply from 2016 to 2019. Low meal-preparation skill is repeatedly
associated with worse diet quality and higher food insecurity; conversely,
kitchen access and food-procurement skill measurably reduce it.

The less obvious and more important finding is *what* they lack. It is not a
shortage of recipes — the web has an effectively infinite supply. The
documented friction is *deciding* what to make, trusting that it will work, and
executing it with the equipment, time and skill actually on hand. Even
SuperCook, the established leader in "what can I make," is criticised by its
own reviewers for returning a long list instead of a decision.

A second, separately well-corroborated pain is the state of existing recipe
content: long personal essays before the method, dense ads, and paywalls that
appear mid-cook. This is anecdotal in its specifics (traffic-drop percentages
vary by source) but consistent across every source reviewed, and it is
structurally explained: the essay exists because a bare ingredient list is not
copyrightable and generates no ad revenue on its own, so publishers pad it.

*Framing to hold onto:* the product answers "what should I cook, and can I
actually pull it off" — not "give me more recipes."

= Target user

*Decided* (confirmed by the Owner and Developer).

*Primary persona:* a student or young adult in a shared or minimal kitchen —
a dorm hot-plate-and-microwave setup, or a first apartment with one or two
pans and no specialty equipment. Low cooking skill, tight budget, cooks a
few times a week out of necessity rather than interest. Today, this person
gets by on takeout, a small repertoire of memorised dishes, and recipes
picked up from short-form video (TikTok, YouTube Shorts) rather than
recipe websites, which they find slow, ad-heavy and unreliable. This
persona is deliberately generic by country: the constraint is the kitchen
and the budget, not a cuisine or a region.

*Explicitly not for:*
- Confident or hobbyist cooks looking for technique, inspiration, or variety.
- People who already cook regularly and want to organise or import *their own*
  recipes — that is Paprika's and Mealie's job, not this one.
- People who want a large-scale, community-driven recipe archive as the main
  draw — that positioning is Cookpad's, and the research is clear it does not
  work for a solo, no-budget operator.

= Positioning

*Provisional — working hypothesis, to be validated by the Owner:*

#quote(block: true)[
  SmartCooking is a bilingual, ad-free cooking tool that helps a beginner
  decide what to cook and get it right, from a small curated library matched
  to the equipment, time and skill they actually have.
]

*What this is not* (decided, regardless of the open decision below):
- Not an SEO-driven ad blog. No essays before the method, no ad slots, no
  paywall to read a recipe.
- Not a mobile app. The web experience is mobile-first for use at the stove,
  but there is no native app in scope.
- Not a precise cost calculator. See per-serving cost estimation, below.
- Not a community platform as its core identity — even if user submissions
  ship at some point (the open decision), the product is a tool with a
  curated library first, and community features are a layer on top of that,
  not the reason it exists.

= Value proposition and differentiators

The research is blunt that none of the following are defensible moats — they
are execution-quality advantages that a well-funded competitor could copy.
They are still worth doing well, honestly, because none of the incumbents
currently do all of them at once.

== Equipment and constraint filtering

*Recommendation:* commit. This is the one differentiator worth building.

*Evidence:* no major recipe database treats equipment as a first-class filter;
only meal-kit services and appliance-brand blogs touch it, narrowly. It maps
directly onto the target persona's actual constraint (a hot plate is not an
oven), and it is buildable by one developer against a small, hand-tagged
catalogue.

*What would change it:* nothing found in the research argues against this;
it is the lowest-risk part of the plan.

== Pantry and ingredient search ("what can I make with X")

*Recommendation:* defer.

*Evidence:* real, well-documented demand, but SuperCook already serves it,
for free, at a scale (millions of recipes) that makes match quality
fundamentally better than a 20-30 recipe catalogue could offer at launch.
Building this against a small library would showcase the product's biggest
weakness, not its strength.

*What would change it:* a catalogue large enough (likely several hundred
recipes) that ingredient coverage stops being the limiting factor. Not
expected within V1's horizon.

== Per-serving cost estimation

*Recommendation:* drop automated estimation entirely.

*Evidence:* no free, current, international ingredient-price data source
exists. Grocery prices vary roughly 3-16x across countries and swing double
digits year over year; even Budget Bytes, the category leader on cost
transparency, computes its numbers by hand, recipe by recipe, and says
publicly that keeping a large catalogue updated this way is not feasible.
Automating this for an international, bilingual catalogue would produce
numbers that are wrong by construction.

*What a coarse indicator would (and would not) deliver:* an optional,
hand-set relative tag (e.g. \$ / \$\$ / \$\$\$) set by the Owner when she
writes a recipe could signal "cheap staples" vs "a few pricier items" without
claiming precision. It would *not* give a real dollar or euro figure, would
not account for what a given cook already has in their kitchen, and would go
stale exactly like every other manual cost figure. *This coarse indicator is
not in V1 scope* (see Scope) and would only be considered if the Owner wants
to hand-tag it herself.

= The open decision: recipe submissions in V1?

*This decision belongs to the Owner. It is not resolved in this document.*
Everything in Scope, Content and Roles below that depends on it is marked.

*Option A — curated-only in V1, submissions deferred to V2.*
- Case for: matches the research's central recommendation — a solo operator
  with a thin, 20-30 recipe catalogue has no moderation capacity and no
  "empty room" to fill with someone else's contributions yet. Keeps V1 small
  and shippable. Avoids the specific failure mode that damaged Cookpad
  (unpaid-contributor UGC that never covered its costs).
- Consequence for scope: no submission form, no per-submission copyright or
  allergen-tagging workflow, no moderation queue at all in V1.

*Option B — allow submissions from V1.*
- Case for: seeds content faster against a small starting catalogue,
  matches "recipe sharing" as a name and an ambition the Owner may want from
  day one, and gets community mechanics validated early rather than bolted
  on later.
- Consequence for scope: a submission flow that enforces "your own words"
  (ingredients and steps are not copyrightable, but another author's prose or
  photos are), mandatory structured allergen tagging, and a moderation queue
  live at launch — a meaningfully larger V1 than Option A.

Either way, the persona, positioning and the four committed differentiators
above are unaffected — this decision changes the size and risk of V1, not
what the product is for.

= Scope

== V1

- *(Decided)* Bilingual (English / French) recipe pages from day one — no
  hard-coded strings, no single-locale shortcuts to unwind later.
- *(Decided)* Recipe-first page layout: no essay before the method, no ads.
- *(Decided)* Cook mode: large text, screen stays awake, step-by-step with
  inline quantities.
- *(Decided)* Servings scaler.
- *(Decided)* Equipment / skill-level / time filters (the committed
  differentiator).
- *(Decided)* Optional accounts (magic-link, no password) — browsing,
  reading and cooking never require an account. An account is only needed to
  save favourites and personal lists.
- *(Decided)* Print view.
- *(Decided)* Valid `schema.org` Recipe structured data (JSON-LD) on every
  recipe page.
- *(Decided)* Accessibility basics: semantic markup, sufficient contrast,
  keyboard navigation.
- *(Decided)* A minimal admin interface: create, edit, publish and unpublish
  a recipe in both languages. Needed from V1 because the Owner cannot
  operate the catalogue any other way.
- *(Decided)* Privacy-by-default: no third-party analytics or trackers,
  server-side aggregate logs only, a written privacy policy.
- *(Decided)* An optional donations link (e.g. Ko-fi or GitHub Sponsors),
  clearly framed as support, not a paywall or a revenue plan.
- *(Provisional — Owner to confirm number)* 20-30 curated recipes at launch,
  written, tested and tagged by the Owner, in both languages.
- *(Depends on the open decision above)* If Option B: a recipe-submission
  form with copyright guidance and mandatory allergen tagging, plus a
  recipe-moderation queue. If Option A: none of this is in V1.

== Deferred

- Comments and likes on recipes — the accounts model still supports
  favourites and lists in V1; the lighter social layer (liking, commenting)
  is deferred until there is a moderation and disclaimer story in place for
  it, likely alongside or after the open decision on recipe submissions.
- User-submitted recipes, if the Owner picks Option A now — reconsidered once
  there is steady readership or a demonstrated stream of willing
  contributors, not on a calendar date.
- Pantry / ingredient-based search — reconsidered once the catalogue is large
  enough that match quality would be competitive.
- A hand-set relative cost indicator (\$ / \$\$ / \$\$\$) — reconsidered if
  the Owner wants to take this on manually; not automated either way.
- Richer personalisation or recommendations.
- A native mobile app.

== Rejected

- Automated, precise per-serving cost calculation — no viable data source
  exists for an international, bilingual catalogue; the category leader
  does this by hand and says it does not scale even for them.
- Ads and affiliate monetisation — contradicts the core "no ads, no essays"
  differentiator and the target user's documented frustration with exactly
  that.
- Community-as-core-identity (the Cookpad model) — the evidence is that this
  fails without funded moderation and a large volunteer base, neither of
  which a solo project has.
- SEO-driven content strategy (long-form essays, keyword padding) — organic
  search for recipe content is contracting sharply (AI Overviews, AI-written
  content, short-form video); building for a shrinking channel is not a plan.

= Content

The catalogue is the Owner's work: writing each recipe, cooking and
correcting it, tagging it for equipment, time and skill, and — per the
bilingual decision above — producing it in both English and French. That
last point roughly doubles the writing and tagging effort per recipe compared
to a single-language V1, which is the main reason the launch target is kept
conservative.

*(Provisional — Owner to confirm)* Target for V1: 20-30 recipes, each
complete in both languages, tested, and tagged. A smaller number actually
delivered and correct is worth more than a larger number promised and
abandoned.

Stated plainly, because it is the project's real dependency risk and not a
technical one: *if content production stops, the product does not exist.*
No amount of engineering substitutes for a working, trustworthy recipe.

= Roles

- *Owner* (non-technical): product scope, content (writing, testing,
  tagging, and translating or directing translation of every recipe), all
  editorial calls.
- *Developer*: architecture, infrastructure, security, the bilingual content
  model, and advice on scope — not final say on any product decision above.
- *Both* need the admin interface described in Scope; neither can operate the
  catalogue without it.

= Success metrics and anti-metrics

Metrics are restricted to what is measurable from server-side logs and the
database alone, per the privacy-by-default decision — no session tracking,
no funnels, no third-party analytics.

*Metrics worth watching:*
- Recipes saved or added to a list (signals the catalogue is useful, not just
  browsed).
- Catalogue health: proportion of recipes complete in both languages, fully
  tagged, with no open error reports.
- Monthly running cost held under an agreed hobby-budget ceiling.

*Anti-metrics — deliberately not optimised for:*
- Pageviews or time-on-page (the mechanism that produced the essay-and-ads
  problem this product exists to avoid).
- Raw comment or submission counts as a goal in themselves.
- Registered-account count as a vanity number.
- Any SEO ranking as a primary target — organic search is a declining,
  unreliable channel for this content category and is treated as hygiene,
  not as a goal.

= Constraints and risks

*Cost:* running this will cost real, recurring money — a small server,
managed Postgres, object storage for images, transactional email for
magic links — on the order of tens of dollars a month, growing with image
storage and bandwidth. *(Provisional — Owner to confirm)* donations are
enabled as an option, but the project is not expected to break even, and
that is accepted going in, not a fallback if growth disappoints.

*Legal exposure — needs real legal review, not resolved here:*
- *Recipe copyright:* ingredient lists and plain method steps are not
  protectable; another author's prose (headnotes, stories) and photos are.
  This matters most if Option B is chosen for the open decision above, but
  applies even to the Owner's own sourcing of inspiration for curated
  recipes.
- *User-generated content liability:* with comments and likes deferred, V1
  has no user-generated content surface unless the Owner picks Option B for
  the open decision above — in which case the moderation and no-warranty
  disclaimer work described there is needed at launch, not deferred to V2.
- *Allergen and food-safety disclaimers:* any allergen tagging is
  information, never a safety guarantee; users must be told to verify labels
  themselves.
- *Privacy — Quebec Law 25 and GDPR:* both apply given the Developer's
  location and an internationally-neutral audience. Practical
  implications flagged by the research include designating a privacy-
  responsible person, a public privacy policy, opt-in consent for any
  non-essential tracking, and data-portability and deletion rights. This
  needs confirmation from a qualified advisor before launch, not just this
  document's word for it.

= Decisions requiring the Owner's confirmation

This document contains one unresolved question and several provisional
calls. Listed together so they can be walked through directly:

+ *The open decision:* can users publish recipes in V1, or is V1
  curated-only with submissions deferred to V2? (Section: "The open
  decision.")
+ *Persona and positioning:* does the target user and the one-sentence
  positioning statement actually describe what she wants to build?
+ *Bilingual from day one:* is she able and willing to produce every launch
  recipe in both English and French, given that this roughly doubles the
  content workload for the same launch date?
+ *Content target:* is 20-30 recipes, complete in both languages and tested,
  a number she can commit to before launch?
+ *Donations:* is she comfortable with the site accepting donations (Ko-fi
  or similar), even though the project is explicitly not trying to make
  money?
+ *Deferred and rejected lists:* any objection to permanently dropping
  automated cost estimation, ads, and a community-first identity, or to
  deferring pantry search and user submissions (if Option A is chosen)?
