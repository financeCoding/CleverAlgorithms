# Genetic Algorithm in the Perl Programming Language

# The Clever Algorithms Project: http://www.CleverAlgorithms.com
# (c) Copyright 2010 Jason Brownlee. Some Rights Reserved. 
# This work is licensed under a Creative Commons Attribution-Noncommercial-Share Alike 2.5 Australia License.

use constant NUM_GENERATIONS => 100;
use constant NUM_BOUTS => 3;
use constant POP_SIZE => 100;
use constant NUM_BITS => 64;
use constant P_CROSSOVER => 1;
use constant P_MUTATION => (1.0/NUM_BITS);
use constant HALF => 0.5;

sub onemax {
	my $sum = 0;
	while ($_[0]=~ /(.)/g) {
		if($1 == '1') {
			$sum = $sum + 1;
		}		
	}
  	return $sum;
}

sub mutation {
	my $string = "";
	while ($_[0]=~ /(.)/g) {
		if(rand() < P_MUTATION) {
			if($1=='1') {
				$string = $string . "0"
			}else{
				$string = $string . "1"
			}
		} else { 
      		$string = $string . $1;
		}
  }
  return $string;
}

sub crossover {
	my ($parent1, $parent2) = ($_[1], $_[3]);
	if(rand() < P_CROSSOVER) {
		my $cut = int(rand(NUM_BITS-2)) + 1;
		my @p1 = split(//,$parent1);
		my @p2 = split(//,$parent2);
		return (join('',@p1[0..$cut-1],@p2[$cut..NUM_BITS-1]), join('',@p2[0..$cut-1],@p1[$cut..NUM_BITS-1]));
	}
	return ("".$parent1, "".$parent2);
}

sub random_bitstring {
	my $string = "";
	for my $p (0..(NUM_BITS-1)) {
		if(rand() < HALF) {
			$string = $string."0";
		}else{
			$string = $string."1";
		}
	}
	return $string;
}


# testing...
print(onemax("001111100")."\n");
print(mutation("11111111")."\n");
print("random string: ".random_bitstring()."\n");

%s1 = (bitstring => '111111111');
%s2 = (bitstring => '000000000');
my ($c1, $c2) = crossover(%s1, %s2);
print("rs1: ".$c1."\n");
print("rs2: ".$c2."\n");
