
-- could be tuples {JTYPE, list}
-- where list is an array of tuples.

enum type JTYPE
    JSTRING,
    JNUMBER,
    JOBJECT, -- name, value pair
    JARRAY,
    JBOOLEAN, -- true or false
    JNULL, -- no data
    $
end type

sequence jobj
jobj = {
    JOBJECT,
    {"name", JSTRING, "value pair"},
    {"numbers", JARRAY, {JNUMBER, 1, 2, 3}},
    $
}
