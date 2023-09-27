
include std/pretty.e

ifdef DEBUG then
with trace
end ifdef

include eujson.e

sequence test = `
{
"name":"John",
"age":30,
"cars":["Ford", "BMW", "Fiat"],
"cars2":[["Ford"], ["BMW"], ["Fiat"]]
}`

trace(1)

object ob

ob = JSON:parse(test)
if ob[1] != GET_SUCCESS then
    puts(1, "Error in processing JSON.\n")
    --abort(1)
end if
ob = ob[2]

pretty_print(1, ob, {3})

puts(1, "\n" & test & "\n")
