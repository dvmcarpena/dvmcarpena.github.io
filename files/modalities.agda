{-# OPTIONS --without-K --exact-split --no-import-sorts --auto-inline #-}
module modalities where

-- Universe levels

open import Agda.Primitive
  using (Level; lzero; lsuc; _⊔_)
  renaming (Set to UU; Setω to UUω)
  public

-- Functions

id : {i : Level} {A : UU i} → A → A
id a = a

_∘_ :
  {i j k : Level} {A : UU i} {B : A → UU j} {C : (a : A) → B a → UU k} →
  ({a : A} → (b : B a) → C a b) → (f : (a : A) → B a) → (a : A) → C a (f a)
(g ∘ f) a = g (f a)

ev-pt :
  {l1 l2 : Level} {A : UU l1} (a : A) (B : A → UU l2) → ((x : A) → B x) → B a
ev-pt a B f = f a

precomp-Π :
  {l1 l2 l3 : Level} {A : UU l1} {B : UU l2} (f : A → B) (C : B → UU l3) →
  ((b : B) → C b) → ((a : A) → C (f a))
precomp-Π f C h a = h (f a)

precomp :
  {l1 l2 l3 : Level} {A : UU l1} {B : UU l2} (f : A → B) (C : UU l3) →
  (B → C) → (A → C)
precomp f C = precomp-Π f (λ b → C)

postcomp :
  {l1 l2 l3 : Level} {X : UU l1} {Y : UU l2} (A : UU l3) →
  (X → Y) → (A → X) → (A → Y)
postcomp A f h = f ∘ h

map-Π :
  {l1 l2 l3 : Level} {I : UU l1} {A : I → UU l2} {B : I → UU l3}
  (f : (i : I) → A i → B i) →
  ((i : I) → A i) → ((i : I) → B i)
map-Π f h i = f i (h i)

map-Π' :
  {l1 l2 l3 l4 : Level} {I : UU l1} {A : I → UU l2} {B : I → UU l3}
  {J : UU l4} (α : J → I) →
  ((i : I) → A i → B i) → ((j : J) → A (α j)) → ((j : J) → B (α j))
map-Π' α f = map-Π (λ j → f (α j))

-- Dependent Pair Types

record Σ {l1 l2} (A : UU l1) (B : A → UU l2) : UU (l1 ⊔ l2) where
  constructor pair
  field
    pr1 : A
    pr2 : B pr1

open Σ public

{-# BUILTIN SIGMA Σ #-}

infixr 10 _,_
pattern _,_ a  b = pair a b

ind-Σ :
  {l1 l2 l3 : Level} {A : UU l1} {B : A → UU l2} {C : Σ A B → UU l3} →
  ((x : A) (y : B x) → C (pair x y)) → ((t : Σ A B) → C t)
ind-Σ f (pair x y) = f x y

ev-pair :
  {l1 l2 l3 : Level} {A : UU l1} {B : A → UU l2} {C : Σ A B → UU l3} →
  ((t : Σ A B) → C t) → (x : A) (y : B x) → C (pair x y)
ev-pair f x y = f (pair x y)

triple :
  {l1 l2 l3 : Level} {A : UU l1} {B : A → UU l2} {C : (x : A) → B x → UU l3} →
  (a : A) (b : B a) → C a b → Σ A (λ x → Σ (B x) (C x))
pr1 (triple a b c) = a
pr1 (pr2 (triple a b c)) = b
pr2 (pr2 (triple a b c)) = c

triple' :
  {l1 l2 l3 : Level} {A : UU l1} {B : A → UU l2} {C : Σ A B → UU l3} →
  (a : A) (b : B a) → C (pair a b) → Σ (Σ A B) C
pr1 (pr1 (triple' a b c)) = a
pr2 (pr1 (triple' a b c)) = b
pr2 (triple' a b c) = c

module _
  {l1 l2 l3 : Level} {A : UU l1} {B : A → UU l2}
  where

  fam-Σ : ((x : A) → B x → UU l3) → Σ A B → UU l3
  fam-Σ C (pair x y) = C x y

  
prod : {l1 l2 : Level} (A : UU l1) (B : UU l2) → UU (l1 ⊔ l2)
prod A B = Σ A (λ a → B)

pair' :
  {l1 l2 : Level} {A : UU l1} {B : UU l2} → A → B → prod A B
pair' = pair

_×_ :  {l1 l2 : Level} (A : UU l1) (B : UU l2) → UU (l1 ⊔ l2)
A × B = prod A B

-- open import foundation.empty-types
-- open import foundation.universal-property-empty-type
-- open import foundation.unit-type
-- open import foundation.identity-types

-- Identity Types

module _
  {l : Level} {A : UU l}
  where

  data Id (x : A) : A → UU l where
    refl : Id x x

  _＝_ : A → A → UU l
  (a ＝ b) = Id a b

{-# BUILTIN EQUALITY Id #-}

ind-Id :
  {l1 l2 : Level} {A : UU l1}
  (x : A) (B : (y : A) (p : x ＝ y) → UU l2) →
  (B x refl) → (y : A) (p : x ＝ y) → B y p
ind-Id x B b y refl = b

module _
  {l : Level} {A : UU l}
  where

  _∙_ : {x y z : A} → x ＝ y → y ＝ z → x ＝ z
  refl ∙ q = q

  concat : {x y : A} → x ＝ y → (z : A) → y ＝ z → x ＝ z
  concat p z q = p ∙ q

  concat' : (x : A) {y z : A} → y ＝ z → x ＝ y → x ＝ z
  concat' x q p = p ∙ q

  inv : {x y : A} → x ＝ y → y ＝ x
  inv refl = refl

  assoc :
    {x y z w : A} (p : x ＝ y) (q : y ＝ z) (r : z ＝ w) →
    ((p ∙ q) ∙ r) ＝ (p ∙ (q ∙ r))
  assoc refl q r = refl

  left-unit : {x y : A} {p : x ＝ y} → (refl ∙ p) ＝ p
  left-unit = refl

  right-unit : {x y : A} {p : x ＝ y} → (p ∙ refl) ＝ p
  right-unit {p = refl} = refl

  left-inv : {x y : A} (p : x ＝ y) → ((inv p) ∙ p) ＝ refl
  left-inv refl = refl

  right-inv : {x y : A} (p : x ＝ y) → (p ∙ (inv p)) ＝ refl
  right-inv refl = refl

  inv-inv : {x y : A} (p : x ＝ y) → (inv (inv p)) ＝ p
  inv-inv refl = refl

  distributive-inv-concat :
    {x y : A} (p : x ＝ y) {z : A} (q : y ＝ z) →
    (inv (p ∙ q)) ＝ ((inv q) ∙ (inv p))
  distributive-inv-concat refl refl = refl

inv-con :
  {l : Level} {A : UU l} {x y : A} (p : x ＝ y) {z : A} (q : y ＝ z)
  (r : x ＝ z) → ((p ∙ q) ＝ r) → q ＝ ((inv p) ∙ r)
inv-con refl q r s = s

con-inv :
  {l : Level} {A : UU l} {x y : A} (p : x ＝ y) {z : A} (q : y ＝ z)
  (r : x ＝ z) → ((p ∙ q) ＝ r) → p ＝ (r ∙ (inv q))
con-inv p refl r s = ((inv right-unit) ∙ s) ∙ (inv right-unit)

-- Equivalences

module _
  {l1 l2 : Level} {A : UU l1} {B : A → UU l2}
  where

  _~_ : (f g : (x : A) → B x) → UU (l1 ⊔ l2)
  f ~ g = (x : A) → (f x ＝ g x)

module _
  {l1 l2 : Level} {A : UU l1} {B : UU l2}
  where

  sec : (A → B) → UU (l1 ⊔ l2)
  sec f = Σ (B → A) (λ g → (f ∘ g) ~ id)

  retr : (f : A → B) → UU (l1 ⊔ l2)
  retr f = Σ (B → A) (λ g → (g ∘ f) ~ id)

  is-equiv : (A → B) → UU (l1 ⊔ l2)
  is-equiv f = sec f × retr f

_≃_ :
  {i j : Level} (A : UU i) (B : UU j) → UU (i ⊔ j)
A ≃ B = Σ (A → B) is-equiv

-- open import foundation.equivalences

-- open import foundation.retractions
-- open import foundation.sections
-- open import foundation.propositions
-- open import foundation.function-extensionality
-- open import foundation.small-types
-- open import foundation.locally-small-types
-- open import foundation.functoriality-dependent-function-types
-- open import foundation.contractible-types
-- open import foundation.contractible-maps
-- open import foundation.type-arithmetic-dependent-function-types
-- open import foundation.type-arithmetic-unit-type
-- open import foundation.subuniverses

-- Modalities

modal-operator : (l1 l2 : Level) → UU (lsuc l1 ⊔ lsuc l2)
modal-operator l1 l2 = UU l1 → UU l2

modal-unit : {l1 l2 : Level} → modal-operator l1 l2 → UU (lsuc l1 ⊔ l2)
modal-unit {l1} ○ = {X : UU l1} → X → ○ X


module _
  {l1 l2 : Level} {○ : modal-operator l1 l2} (unit-○ : modal-unit ○)
  where

  is-modal : (X : UU l1) → UU (l1 ⊔ l2)
  is-modal X = is-equiv (unit-○ {X})

  modal-types : UU (lsuc l1 ⊔ l2)
  modal-types = Σ (UU l1) (is-modal)

module _
  {l1 l2 : Level} {Y : UU l1} {X : UU l2} (f : Y → X)
  where

  is-local-family : {l : Level} → (X → UU l) → UU (l1 ⊔ l2 ⊔ l)
  is-local-family A = is-equiv (precomp-Π f A)

  is-local-type : {l : Level} → UU l → UU (l1 ⊔ l2 ⊔ l)
  is-local-type A = is-local-family (λ _ → A)


