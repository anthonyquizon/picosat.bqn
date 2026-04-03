FFI←{"../cbits/picosat/libpicosat.so" •FFI 𝕩}

c_init     ← FFI "*"‿"picosat_init"
c_reset    ← FFI ""‿"picosat_reset"‿"*"
c_set_seed ← FFI ""‿"picosat_set_seed"‿"*"‿"i32"
c_print    ← FFI ""‿"picosat_print"‿"*"‿"*u32"
c_sat      ← FFI "i32"‿"picosat_sat"‿"*"‿"i32"
c_add      ← FFI "i32"‿"picosat_add"‿"*"‿"i32"   # add variable. -x = false and +x = true for var x. 0 for terminating clause
c_deref    ← FFI "i32"‿"picosat_deref"‿"*"‿"i32" # gets variable value in a solution

Init←{𝕊:
  res←{ none‿sat‿unsat⇐0‿10‿20 }

  p←C_init ⟨⟩
  Add⇐{ C_add¨p⊸∾⌜∾∾⟜0¨𝕩 }
  Sat⇐{
      𝕊 𝕩: ¯1 𝕊 𝕩
  ; 𝕨 𝕊 𝕩: res.sat≡C_sat p‿𝕨? # 𝕩 a list of variables to defref
      𝕩×C_deref¨p⊸∾⌜𝕩 # return literals under variable index
  ; 𝕨 𝕊 𝕩: ⟨⟩ 
  }

  # TODO add deref to new clause and regen
  End⇐{𝕊: C_reset⋈p }
}


s←Init@
#c← ⟨
  #1‿2‿3, ¯1‿¯2, ¯1‿¯3, ¯2‿¯3, 4‿5‿6, ¯4‿¯5, ¯4‿¯6, ¯5‿¯6, 7‿8‿9, ¯7‿¯8, ¯7‿¯9, ¯8‿¯9, 1‿4‿7, ¯1‿¯4, ¯1‿¯7, ¯4‿¯7, 2‿5‿8, 
  #¯2‿¯5, ¯2‿¯8, ¯5‿¯8, 3‿6‿9, ¯3‿¯6, ¯3‿¯9, ¯6‿¯9, ¯4‿¯8, ¯1‿¯5, ¯1‿¯9, ¯5‿¯9, ¯2‿¯6, ¯6‿¯8, ¯3‿¯5, ¯3‿¯7, ¯5‿¯7, ¯2‿¯4,
#⟩
# nqueens clauses
c← ⟨
1‿2‿3‿4
¯1‿¯2
¯1‿¯3
¯1‿¯4
¯2‿¯3
¯2‿¯4
¯3‿¯4
5‿6‿7‿8
¯5‿¯6
¯5‿¯7
¯5‿¯8
¯6‿¯7
¯6‿¯8
¯7‿¯8
9‿10‿11‿12
¯9‿¯10
¯9‿¯11
¯9‿¯12
¯10‿¯11
¯10‿¯12
¯11‿¯12
13‿14‿15‿16
¯13‿¯14
¯13‿¯15
¯13‿¯16
¯14‿¯15
¯14‿¯16
¯15‿¯16
1‿5‿9‿13
¯1‿¯5
¯1‿¯9
¯1‿¯13
¯5‿¯9
¯5‿¯13
¯9‿¯13
2‿6‿10‿14
¯2‿¯6
¯2‿¯10
¯2‿¯14
¯6‿¯10
¯6‿¯14
¯10‿¯14
3‿7‿11‿15
¯3‿¯7
¯3‿¯11
¯3‿¯15
¯7‿¯11
¯7‿¯15
¯11‿¯15
4‿8‿12‿16
¯4‿¯8
¯4‿¯12
¯4‿¯16
¯8‿¯12
¯8‿¯16
¯12‿¯16
¯9‿¯14
¯5‿¯10
¯5‿¯15
¯10‿¯15
¯1‿¯6
¯1‿¯11
¯1‿¯16
¯6‿¯11
¯6‿¯16
¯11‿¯16
¯2‿¯7
¯2‿¯12
¯7‿¯12
¯3‿¯8
¯12‿¯15
¯8‿¯11
¯8‿¯14
¯11‿¯14
¯4‿¯7
¯4‿¯10
¯4‿¯13
¯7‿¯10
¯7‿¯13
¯10‿¯13
¯3‿¯6
¯3‿¯9
¯6‿¯9
¯2‿¯5
⟩
s.Add c
r←s.Sat ⍷∾|c

# DO no goods 
•Show r
#•Show 0⌈×4‿4⥊r

