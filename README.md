# SavingMemoLines
Demonstrating Saving TMemoLines to Logfile
## Summary
This is a small project that demonstrates how saving lines from a `TMemo` differs from saving lines from a `TStrings` class. `TMemo` uses a descendant class for lines named `TMemoLines` that does not honor the `TrailingLinebreak` option of `TStrings`.

For a more complete explanation, see the blog post at:
[Delphi Chops](https://delphichops.blogspot.com/2021/04/tmemolines-and-filestream.html "Delphi Chops at Blogger")

You can download or clone this project group that illustrates some of the differences between `TMemoLines` and `TStrings` affect the `TFileStream` output.
