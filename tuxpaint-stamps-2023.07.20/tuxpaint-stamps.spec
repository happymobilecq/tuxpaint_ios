Summary: Rubber stamps collection for Tux Paint.
Name: tuxpaint-stamps
Version: 2023.07.20
Release: 1
License: GPL
Group: Multimedia/Graphics
URL: https://tuxpaint.org/
Source0: %{name}-%{version}.tar.gz
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
BuildArch: noarch

%description
This package contains a set of 'Rubber Stamp' images which can be used
with the "Stamp" tool within Tux Paint. (It also contains a small
script which provides the means to install the stamps.)


%package animals
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description animals
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package clothes
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description clothes
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package food
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description food
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package hobbies
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description hobbies
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package household
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description household
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package medical
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description medical
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package military
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description military
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package naturalforces
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description naturalforces
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package people
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description people
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package plants
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description plants
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package seasonal
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description seasonal
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package space
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description space
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package sports
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description sports
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package symbols
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description symbols
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package town
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description town
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%package vehicles
Summary: Rubber stamps collection for Tux Paint.
Group: Multimedia/Graphics
Requires: tuxpaint

%description vehicles
tuxpaint-stamps-xxx package contains a set of 'Rubber Stamp' images
which can be used with the "Stamp" tool within Tux Paint. (It also
contains a small script which provides the means to install the
stamps.)

%prep
%setup -q

%build

%install
rm -rf $RPM_BUILD_ROOT
make DATA_PREFIX=$RPM_BUILD_ROOT/%{_datadir}/tuxpaint/ install-all

%clean
rm -rf $RPM_BUILD_ROOT

%files animals
%{_datadir}/tuxpaint/stamps/animals

%files clothes
%{_datadir}/tuxpaint/stamps/clothes

%files food
%{_datadir}/tuxpaint/stamps/food

%files hobbies
%{_datadir}/tuxpaint/stamps/hobbies

%files household
%{_datadir}/tuxpaint/stamps/household

%files medical
%{_datadir}/tuxpaint/stamps/medical

%files military
%{_datadir}/tuxpaint/stamps/military

%files naturalforces
%{_datadir}/tuxpaint/stamps/naturalforces

%files people
%{_datadir}/tuxpaint/stamps/people

%files plants
%{_datadir}/tuxpaint/stamps/plants

%files seasonal
%{_datadir}/tuxpaint/stamps/seasonal

%files space
%{_datadir}/tuxpaint/stamps/space

%files sports
%{_datadir}/tuxpaint/stamps/sports

%files symbols
%{_datadir}/tuxpaint/stamps/symbols

%files town
%{_datadir}/tuxpaint/stamps/town

%files vehicles
%{_datadir}/tuxpaint/stamps/vehicles

%changelog

* Fri Sep 08 2006 TOYAMA Shin-ichi <dolphin6k@wmail.plala.or.jp> -
- version 2006.09.08
- Initial build for separated packaging.
