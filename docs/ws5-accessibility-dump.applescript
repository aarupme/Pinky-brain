on indentText(depth)
  set outputText to ""
  repeat depth times
    set outputText to outputText & "  "
  end repeat
  return outputText
end indentText

on dumpElement(uiElement, depth, maxDepth)
  if depth > maxDepth then return

  set roleText to ""
  set nameText to ""
  set valueText to ""

  try
    set roleText to role of uiElement as text
  end try

  try
    set nameText to name of uiElement as text
  end try

  try
    set valueText to value of uiElement as text
  end try

  set lineText to my indentText(depth) & "role=" & roleText & " | name=" & nameText & " | value=" & valueText

  if length of lineText > 700 then
    set lineText to text 1 thru 700 of lineText
  end if

  log lineText

  try
    set childElements to UI elements of uiElement
    repeat with childElement in childElements
      my dumpElement(childElement, depth + 1, maxDepth)
    end repeat
  end try
end dumpElement

tell application "System Events"
  tell process "ChatGPT"
    my dumpElement(window 1, 0, 7)
  end tell
end tell
