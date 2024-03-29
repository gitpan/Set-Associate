use v5.16;
use warnings;

use Test::More;
use Set::Associate;
use Set::Associate::NewKey::HashMD5;
use Set::Associate::RefillItems::Linear;

my $et = Set::Associate->new(
  on_items_empty => Set::Associate::RefillItems::Linear->new(
    items => [qw( hello world this is a test )],
  ),
  on_new_key => Set::Associate::NewKey::HashMD5->new(),
);

my $got  = {};
my $xmap = {
  a => world =>,
  b => world =>,
  c => world =>,
  d => is    =>,
  e => a     =>,
  f => test  =>,
  g => test  =>,
};

for my $item (qw( a b c d e f g )) {
  $got->{$item} = $et->get_associated($item);
  ok( defined $got->{$item}, "Got something for << $item >>" );
}

for my $item (qw( a b c d e f g )) {
  is( $got->{$item}, $et->get_associated($item), "Second pass is the same ( $got->{$item} ) " );
}

for my $item (qw( a b c d e f g )) {
  is( $got->{$item}, $xmap->{$item}, "Items are expected values determined by hash ( $got->{$item} ) " );
}

done_testing;

