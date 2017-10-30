#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;

my $data_file = "$FindBin::Bin/data.pl";
my $store = require($data_file);
my @knowledges_database = @{$store->{'data'}};
my $is_playing = 0;

sub ask_question {
  my $about = shift;
  print "$about\n";
  my $response = <STDIN>;
  chomp $response;
  return $response;
}

sub start_msg {
  print $store->{'start'},"\n";
  $is_playing = 1;
}

sub play_again_msg {
  print $store->{'again'},"\n";
}

sub exit_msg {
  print $store->{'exit'},"\n";
}

sub list_known_animals {
  my @known_animals;
  foreach my $animal (sort map { (@{$_})[1,2] } @knowledges_database){
    if (! grep {"$animal" eq "$_"} @known_animals){
      push @known_animals, "$animal";
    }
  }
  print join(', ',  @known_animals), "\n";
}

sub is_exists_question {
  my $subject = shift;
  my $result = (grep { $_->[0] eq "$subject" } @{$store->{'data'}}) >= 1 ? 1 : 0;
  return $result;
}

sub play {
  my ($about,$first,$second) = @_;
  my $answer = ask_question("$about");
  if (("$about" eq 'DO YOU WANT TO EXIT?') && ("$answer" =~ /[Yy]/)){
      $is_playing = 0;
      return $is_playing;
  }
  else{
    if ("$answer" =~ /^(?:l|list)$/i){
        list_known_animals();
        play($store->{'mood'},'','');
    }
    elsif ("$answer" =~ /[Qq]/){
        play($store->{'confirmExit'},'','');
    }
    elsif ("$about" eq 'ARE YOU THINKING OF AN ANIMAL ? ') {
      if ("$answer" =~ /[NnQq]/){
        play($store->{'confirmExit'},'','');
        return;
      }
      elsif ("$answer" =~ /[Yy]/){
        map {
          ($about,$first,$second) = @{$_};
          my $answer = ask_question("$about");
          if ("$answer" =~ /[Yy]/){
            if (ask_question("$store->{'isItA'} $first ?") =~ /[Yy]/){
              play_again_msg();
              play($store->{'mood'},'','');
              return;
            }
          }
          elsif("$answer" =~ /[Nn]/){
            if (ask_question("$store->{'isItA'} $second ?") =~ /[Yy]/){
              play_again_msg();
              play($store->{'mood'},'','');
            }
          }
          elsif ("$answer" =~ /[NnQq]/){
            play($store->{'confirmExit'},'','');
            return;
          }
        } @knowledges_database;
      }
      my $animal = uc ask_question("$store->{'itWas'}");
      my $question = ask_question("$store->{'differ'} $animal $store->{'fromA'} $second");
      my $new_record = [$question, $animal, $second];
      push @knowledges_database, $new_record;
      my $new_datasets = '['.join(', ', map { '['.join(', ', map { '"'.$_.'"' } @{$_}).']' } @knowledges_database).']';
      save_updated_database("$new_datasets");
      play_again_msg();
      play($store->{'mood'},'','');
      return;
    }
    else{
      play($store->{'mood'},'','');
    }
  }
}

sub save_updated_database{
  my $updated_knowledges = shift;
  open my $rh, '<', "$data_file" or die "Error when reading $data_file ($!)";
  my @data_content = <$rh>;
  close $rh;
  open my $wh, '>', "$data_file" or die "Error when writing $data_file ($!)";
  map {
    my $line = $_;
    chomp $line;
    if ($line =~ /"data"/) {
      $line =~ s/^(\s+"data"\s=>\s)(.+?)$/$1$updated_knowledges/;
    }
    print $wh "$line\n";
  } @data_content;
  close $wh;
}

start_msg();
play($store->{'mood'},'','');
exit_msg();
