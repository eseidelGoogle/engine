// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:sky/theme/colors.dart' as colors;
import 'package:sky/theme/typography.dart' as typography;
import 'package:sky/widgets/basic.dart';
import 'package:sky/widgets/default_text_style.dart';
import 'package:sky/widgets/theme.dart';
import 'package:sky/widgets/widget.dart';
import 'package:sky/widgets/task_description.dart';
import 'package:sky/widgets/scaffold.dart';
import 'package:sky/widgets/tool_bar.dart';
import 'package:sky/widgets/icon_button.dart';
import 'package:sky/widgets/floating_action_button.dart';
import 'package:sky/widgets/icon.dart';
import 'package:sky/widgets/material.dart';
import 'package:sky/editing/input.dart';
import 'package:sky/widgets/scrollable_viewport.dart';

class Field extends Component {
  Field(this.state, {this.icon: null, this.placeholder: null});

  InputState state;
  String icon;
  String placeholder;

  Widget build() {
    return new Flex([
        new Padding(
          padding: const EdgeDims.symmetric(horizontal: 16.0),
          child: new Icon(type: icon, size: 24)
        ),
        new Flexible(
          child: new Input(
            state: state,
            placeholder: placeholder
          )
        )
      ],
      direction: FlexDirection.horizontal
    );
  }
}

class InputStates {
  // TODO(eseidel): It's not clear to me that this model-like object should
  // store GlobalKeys for the Inputs in question.  In some apps data could be
  // displayed in more than one place, and each place would get a separate
  // GlobalKey.
  InputState name = new InputState();
  InputState phone = new InputState();
  InputState email = new InputState();
  InputState address = new InputState();
  InputState ringtone = new InputState();
  InputState note = new InputState();
}

class AddressBookApp extends App {
  InputStates states;

  Widget buildToolBar() {
    return new ToolBar(
        left: new IconButton(icon: "navigation/arrow_back"),
        right: [new IconButton(icon: "navigation/check")]
      );
  }

  Widget buildFloatingActionButton() {
    return new FloatingActionButton(
      child: new Icon(type: 'image/photo_camera', size: 24),
      backgroundColor: Theme.of(this).accentColor
    );
  }

  Widget buildBody() {
    return new Material(
      child: new ScrollableBlock([
        new AspectRatio(
          aspectRatio: 16.0 / 9.0,
          child: new Container(
            decoration: new BoxDecoration(backgroundColor: colors.Purple[300])
          )
        ),
        new Field(states.name, icon: "social/person", placeholder: "Name"),
        new Field(states.phone, icon: "communication/phone", placeholder: "Phone"),
        new Field(states.email, icon: "communication/email", placeholder: "Email"),
        new Field(states.address, icon: "maps/place", placeholder: "Address"),
        new Field(states.ringtone, icon: "av/volume_up", placeholder: "Ringtone"),
        new Field(states.note, icon: "content/add", placeholder: "Add note"),
      ])
    );
  }

  Widget buildMain() {
    return new Scaffold(
      toolbar: buildToolBar(),
      body: buildBody(),
      floatingActionButton: buildFloatingActionButton()
    );
  }

  Widget build() {

    ThemeData theme = new ThemeData(
      brightness: ThemeBrightness.light,
      primarySwatch: colors.Teal,
      accentColor: colors.PinkAccent[100]
    );

    return new Theme(
      data: theme,
        child: new DefaultTextStyle(
          style: typography.error, // if you see this, you've forgotten to correctly configure the text style!
          child: new TaskDescription(
            label: 'Address Book',
            child: buildMain()
          )
        )
     );
   }
}

void main() {
  runApp(new AddressBookApp());
}
