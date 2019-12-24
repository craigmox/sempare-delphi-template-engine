(*%****************************************************************************
 *  ___                                             ___               _       *
 * / __|  ___   _ __    _ __   __ _   _ _   ___    | _ )  ___   ___  | |_     *
 * \__ \ / -_) | '  \  | '_ \ / _` | | '_| / -_)   | _ \ / _ \ / _ \ |  _|    *
 * |___/ \___| |_|_|_| | .__/ \__,_| |_|   \___|   |___/ \___/ \___/  \__|    *
 *                     |_|                                                    *
 ******************************************************************************
 *                                                                            *
 *                        VELOCITY TEMPLATE ENGINE                            *
 *                                                                            *
 *                                                                            *
 *          https://www.github.com/sempare/sempare.boot.velocity.oss          *
 ******************************************************************************
 *                                                                            *
 * Copyright (c) 2019 Sempare Limited,                                        *
 *                    Conrad Vermeulen <conrad.vermeulen@gmail.com>           *
 *                                                                            *
 * Contact: info@sempare.ltd                                                  *
 *                                                                            *
 * Licensed under the Apache License, Version 2.0 (the "License");            *
 * you may not use this file except in compliance with the License.           *
 * You may obtain a copy of the License at                                    *
 *                                                                            *
 *   http://www.apache.org/licenses/LICENSE-2.0                               *
 *                                                                            *
 * Unless required by applicable law or agreed to in writing, software        *
 * distributed under the License is distributed on an "AS IS" BASIS,          *
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.   *
 * See the License for the specific language governing permissions and        *
 * limitations under the License.                                             *
 *                                                                            *
 ****************************************************************************%*)
unit Sempare.Boot.Template.Velocity.Functions.Test;

interface

uses
  DUnitX.TestFramework;

type

  [TestFixture]
  TFunctionTest = class
  public

    [Test]
    procedure TestTrim();

    [Test]
    procedure TestSubStr();

    [Test]
    procedure TestSubString();

    [Test]
    procedure TestPos();

    [Test]
    procedure TestLen();

    [Test]
    procedure TestDtNow();

    [Test]
    procedure TestFmt();

    [Test]
    procedure TestFmtDate();

    [Test]
    procedure TestStr();

    [Test]
    procedure TestInt();
  end;

implementation

uses
  System.SysUtils,
  Sempare.Boot.Template.Velocity.Functions,
  Sempare.Boot.Template.Velocity;

{ TFunctionTest }

procedure TFunctionTest.TestDtNow;
var
  s: string;
begin
  s := Velocity.Eval('<% dtnow() %>');
  Assert.IsTrue(s <> '');
end;

procedure TFunctionTest.TestFmt;
begin
  Assert.AreEqual('hello world', Velocity.Eval('<% fmt(''%s %s'', ''hello'', ''world'') %>'));
end;

procedure TFunctionTest.TestFmtDate;
var
  ctx: IVelocityContext;
begin
  ctx := Velocity.Context([eoNoDefaultFunctions]);
  ctx.AddFunction('dtnow',
    function(const AArgs: TArray<TVelocityValue>): TVelocityValue
    begin
      result := 43821;
    end);
    ctx.AddFunction('fmtdt', GFunctionInfo.Items['fmtdt'].FN);
  Assert.AreEqual(formatdatetime('2019-12-22', now), Velocity.Eval(ctx, '<% fmtdt(''yyyy-mm-dd'', dtnow()) %>'));
end;

procedure TFunctionTest.TestInt;
begin
  Assert.AreEqual('123', Velocity.Eval('<% int(''123'') %>'));

end;

procedure TFunctionTest.TestLen;
begin
  Assert.AreEqual('10', Velocity.Eval('<% len(''0123456789'') %>'));
  Assert.AreEqual('5', Velocity.Eval('<% len(''01234'') %>'));
end;

procedure TFunctionTest.TestPos;
begin
  Assert.AreEqual('4', Velocity.Eval('<% pos(''3'',''0123456789'') %>'));
end;

procedure TFunctionTest.TestStr;
begin
  Assert.AreEqual('123', Velocity.Eval('<% str(123) %>'));
end;

procedure TFunctionTest.TestSubStr;
begin
  Assert.AreEqual('012', Velocity.Eval('<% substr(''0123456789'', 1,3) %>'));
  Assert.AreEqual('123', Velocity.Eval('<% substr(''0123456789'', 2,3) %>'));
  Assert.AreEqual('789', Velocity.Eval('<% substr(''0123456789'', 8,3) %>'));
  Assert.AreEqual('56789', Velocity.Eval('<% substr(''0123456789'', -5, 5) %>'));
end;

procedure TFunctionTest.TestSubString;
begin
  Assert.AreEqual('678', Velocity.Eval('<% substring(''0123456789'', 7,9) %>'));
  Assert.AreEqual('56789', Velocity.Eval('<% substring(''0123456789'', -5) %>'));
  Assert.AreEqual('567', Velocity.Eval('<% substring(''0123456789'', -5, -3) %>'));

end;

procedure TFunctionTest.TestTrim;
begin
  Assert.AreEqual('trimmed', Velocity.Eval('<% trim(''   trimmed   '') %>'));
end;

initialization

// TDUnitX.RegisterTestFixture(TFunctionTest);

end.