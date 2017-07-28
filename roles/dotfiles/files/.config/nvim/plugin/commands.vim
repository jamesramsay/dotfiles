" Toggle strikethrough (s̶̶t̶r̶i̶k̶e̶t̶h̶r̶o̶u̶g̶̶h) using combining UTF-8 characters
command! -range -nargs=0 Strikethrough call jamsay#functions#combine_codepoint(<line1>, <line2>, '0336')
