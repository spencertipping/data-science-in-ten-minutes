# wikipedia-cite-extract.pl: count citations by type per article
use strict;
use warnings;
while (<STDIN>)
{
  # Skip rows until we hit a title, which will be stored in $1
  next unless /<title>(.*)<\/title>/;

  # Save the title and read until the end of the article text, counting any
  # citations we find
  my $title = $1;
  my $web   = 0;
  my $other = 0;

  until (eof or ($_ = <STDIN>) =~ /<\/text>/)
  {
    /^web$/ ? ++$web : ++$other for /\{\{cite (\w+)/g;
  }
  print join("\t", $web, $other, $title), "\n";
}
