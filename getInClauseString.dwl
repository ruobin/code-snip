%dw 2.0
var dbParams = {
    "flowDirection" : [4,5,8],
    "msgType": [100,200]
}

fun getDBKey(key)=
{
    "flowDirection": "msgclassification",
    "msgType": "msgtype"
}[key]

fun getInClauseString(dbParams: Object) =
if(isEmpty(dbParams)) ''  else (
    ['flowDirection', 'msgType'] filter (!isEmpty($)) map ($ ++ " in (" ++ (dbParams[$] map ((item, index) -> ":" ++ $ ++ "_" ++ index) joinBy ",") ++ ")") reduce (" " ++$ ++ " AND " ++ $$ ++ " ")
)

output application/json
---
getInClauseString(dbParams)