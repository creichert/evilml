(* Evil ML --- A compiler from ML to C++ template language

   Copyright (C) 2015 Akinori ABE <abe@sf.ecei.tohoku.ac.jp>

   Evil ML is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   Evil ML is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>. *)

type t =
  | Unit
  | Bool
  | Char
  | Int
  | Float
  | Arrow of t list * t (* arguments are uncurried *)
  | Tuple of t list
  | Tconstr of string * t list
  | Var of string option * t option ref (* for destructive unification *)

(** {2 Types} *)

val genvar : ?name:string -> unit -> t

val observe : t -> t
val is_basetype : t -> bool
val unarrow : t -> (t list * t) option

val unify : loc:Location.t -> t -> t -> unit

val pp : Format.formatter -> t -> unit

(** {2 Type schemes} *)

type scheme

type context = (string * scheme) list

val scheme : t -> scheme

val generalize : context -> t -> scheme

val instantiate : scheme -> t

val pp_scheme : Format.formatter -> scheme -> unit

(** {2 Typing contexts} *)

val lookup : loc:Location.t -> string -> context -> scheme
