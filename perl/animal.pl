use strict;
use warnings;
use Data::Dumper;

my $data = require('data.pm');
my $is_playing = 0;
#print Dumper $data;



sub start_msg {
    print $data->{'start'},"\n";
    $is_playing = 1;
}

sub exit_msg {
    print $data->{'exit'},"\n";
}

sub game_loop {
    print "In game...\n";
    while($is_playing){
        my $line = <STDIN>;
        chomp $line;
        if ("$line" eq 'Q'){
            $is_playing = 0;
        }
        else{
            print "$line\n";
        }
    }
}

start_msg();
game_loop();
exit_msg();
