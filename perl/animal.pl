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
    print join(', ',  map { (@{$_})[1,2] } @{$store->{'data'}}), "\n";
}

sub is_exists_question {
  my $subject = shift;
  my $result = (grep { $_->[0] eq "$subject" } @{$store->{'data'}}) >= 1 ? 1 : 0;
  return $result;
}

sub play {
    my ($about,$first,$second) = @_;
    #print "DEBUG: $about,$first,$second => $is_playing\n";
    my $answer = ask_question("$about");

    if (("$about" eq 'DO YOU WANT TO EXIT?') && ("$answer" =~ /[Yy]/)){
        $is_playing = 0;
        return $is_playing;
    }
    else{
      if ("$answer" =~ /^(?:l|list)$/i){
          list_known_animals();
          return;
      }
      elsif ("$answer" =~ /[Qq]/){
          play($store->{'confirmExit'},'','');
      }
      elsif ("$about" eq 'ARE YOU THINKING OF AN ANIMAL ? ') {
        if ("$answer" =~ /[Nn]/){
          play($store->{'confirmExit'},'','');
        }
        elsif ("$answer" =~ /[Yy]/){
          map {
            my $status = play(@{$_});
            return if $status == 0;
           } @knowledges_database;
        }
      }
      elsif(is_exists_question("$about") && ($is_playing == 1)){
        if ("$answer" =~ /[Yy]/){
          if (ask_question("$store->{'isItA'} $first ?") =~ /[Yy]/){
            play_again_msg();
            play($store->{'mood'},'','');
          }
        }
        elsif("$answer" =~ /[Nn]/){
          if (ask_question("$store->{'isItA'} $second ?") =~ /[Yy]/){
            play_again_msg();
            play($store->{'mood'},'','');
          }
        }
        else{
          return;
        }
      }
      else{
          play($store->{'mood'},'','');
      }
    }
}

sub game_loop {
    while($is_playing){
        play($store->{'mood'},'','');
    }
}

start_msg();
game_loop();
exit_msg();
