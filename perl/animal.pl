#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

my $store = require('data.pm');
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
    #print "DEBUG: [$about],[$first],[$second] => [$is_playing]\n";
    my $answer = ask_question("$about");
    #print "DEBUG: [$answer]\n";
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
           } @knowledges_database;
        }
        my $animal = uc ask_question("$store->{'itWas'}");
        my $question = ask_question("$store->{'differ'} $animal $store->{'fromA'} $second");
        my $new_record = [$question, $animal, $second];
        push @knowledges_database, $new_record;
        play_again_msg();
        play($store->{'mood'},'','');
        return;
      }
      else{
          play($store->{'mood'},'','');
      }
    }
}

start_msg();
play($store->{'mood'},'','');
exit_msg();
