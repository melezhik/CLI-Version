my constant %export = ();

sub EXPORT($DISTRIBUTION, &proto) {
    &proto.add_dispatchee:
    my multi sub MAIN(:V(:$version)!) {
        my %meta     := $DISTRIBUTION.meta;
        my $compiler := Compiler.new;
        say $*PROGRAM.basename
          ~ ' - based on '
          ~ %meta<name>
          ~ ' '
          ~ %meta<ver>
          ~ ', running '
          ~ $*RAKU.name
          ~ ' '
          ~ $*RAKU.version
          ~ ' on '
          ~ $compiler.name.tc
          ~ ' '
          ~ $compiler.version.Str.subst(/ '.' g .+/)
        ;
        exit;
    }

    %export
}

=begin pod

=head1 NAME

CLI::Version - add -V / --version parameters to your script

=head1 SYNOPSIS

=begin code :lang<raku>

proto sub MAIN(|) {*}
use CLI::Version $?DISTRIBUTION, &MAIN;

# alternately:
use CLI::Version $?DISTRIBUTION, proto sub MAIN(|) {*}

=end code

=head1 DESCRIPTION

CLI::Version adds a C<multi sub> candidate to the C<&MAIN> function in
your script, that will trigger if the script is called with C<-V> or
C<--version> arguments B<only>.

For instance, in the L<App::Rak|https://raku.land/zef:lizmat/App::Rak>
distribution, which provides a C<rak> CLI, calling C<rak -V> will
result in something like:

=begin code :lang<bash>

    $ rak -V
    rak - based on App::Rak 0.0.2, running Raku 6.d on Rakudo 2022.06

=end code

If the candidate is triggered, it will exit with the default value for
C<exit> (which is usually B<0>).

=head1 IMPLEMENTATION NOTES

Due to the fact that the C<$?DISTRIBUTION> and C<&MAIN> of the code that
uses this module, can B<not> be obtained by a public API, it is necessary
to provide them in the C<use> statement.  This need may disappear in
future versions of the Raku Programming Language.

=head1 AUTHOR

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/CLI-Version .
Comments and Pull Requests are welcome.

If you like this module, or what I’m doing more generally, committing to a
L<small sponsorship|https://github.com/sponsors/lizmat/>  would mean a great
deal to me!

=head1 COPYRIGHT AND LICENSE

Copyright 2022 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
