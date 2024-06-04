// Mocks generated by Mockito 5.4.4 from annotations
// in f_testing_template/test/mocks/report_test.mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:convert' as _i7;
import 'dart:typed_data' as _i9;

import 'package:f_testing_template/data/datasources/remote/i_report_remote_datasource.dart'
    as _i3;
import 'package:f_testing_template/domain/entities/report.dart' as _i5;
import 'package:f_testing_template/domain/repositories/ireportrepository.dart'
    as _i6;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResponse_0 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStreamedResponse_1 extends _i1.SmartFake
    implements _i2.StreamedResponse {
  _FakeStreamedResponse_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [IReportRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockIReportRemoteDataSource extends _i1.Mock
    implements _i3.IReportRemoteDataSource {
  MockIReportRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> addReport(
    _i5.Report? report,
    int? status,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addReport,
          [
            report,
            status,
          ],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<List<_i5.Report>> getAllReports() => (super.noSuchMethod(
        Invocation.method(
          #getAllReports,
          [],
        ),
        returnValue: _i4.Future<List<_i5.Report>>.value(<_i5.Report>[]),
      ) as _i4.Future<List<_i5.Report>>);

  @override
  _i4.Future<bool> deleteReport(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteReport,
          [id],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<bool> rateReport(_i5.Report? report) => (super.noSuchMethod(
        Invocation.method(
          #rateReport,
          [report],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<void> savePendingRecord(_i5.Report? report) => (super.noSuchMethod(
        Invocation.method(
          #savePendingRecord,
          [report],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> uploadToApi(_i5.Report? report) => (super.noSuchMethod(
        Invocation.method(
          #uploadToApi,
          [report],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> uploadPendingRecords() => (super.noSuchMethod(
        Invocation.method(
          #uploadPendingRecords,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}

/// A class which mocks [IReportRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIReportRepository extends _i1.Mock implements _i6.IReportRepository {
  MockIReportRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> addReport(
    _i5.Report? report,
    int? status,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #addReport,
          [
            report,
            status,
          ],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<List<_i5.Report>> getAllReports() => (super.noSuchMethod(
        Invocation.method(
          #getAllReports,
          [],
        ),
        returnValue: _i4.Future<List<_i5.Report>>.value(<_i5.Report>[]),
      ) as _i4.Future<List<_i5.Report>>);

  @override
  _i4.Future<bool> deleteReport(String? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteReport,
          [id],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Future<bool> rateReport(_i5.Report? report) => (super.noSuchMethod(
        Invocation.method(
          #rateReport,
          [report],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockClient extends _i1.Mock implements _i2.Client {
  MockClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Response> head(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #head,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #head,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i4.Future<_i2.Response>);

  @override
  _i4.Future<_i2.Response> get(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #get,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i4.Future<_i2.Response>);

  @override
  _i4.Future<_i2.Response> post(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i7.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #post,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #post,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response>);

  @override
  _i4.Future<_i2.Response> put(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i7.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #put,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #put,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response>);

  @override
  _i4.Future<_i2.Response> patch(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i7.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #patch,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #patch,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response>);

  @override
  _i4.Future<_i2.Response> delete(
    Uri? url, {
    Map<String, String>? headers,
    Object? body,
    _i7.Encoding? encoding,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #delete,
          [url],
          {
            #headers: headers,
            #body: body,
            #encoding: encoding,
          },
        ),
        returnValue: _i4.Future<_i2.Response>.value(_FakeResponse_0(
          this,
          Invocation.method(
            #delete,
            [url],
            {
              #headers: headers,
              #body: body,
              #encoding: encoding,
            },
          ),
        )),
      ) as _i4.Future<_i2.Response>);

  @override
  _i4.Future<String> read(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #read,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<String>.value(_i8.dummyValue<String>(
          this,
          Invocation.method(
            #read,
            [url],
            {#headers: headers},
          ),
        )),
      ) as _i4.Future<String>);

  @override
  _i4.Future<_i9.Uint8List> readBytes(
    Uri? url, {
    Map<String, String>? headers,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #readBytes,
          [url],
          {#headers: headers},
        ),
        returnValue: _i4.Future<_i9.Uint8List>.value(_i9.Uint8List(0)),
      ) as _i4.Future<_i9.Uint8List>);

  @override
  _i4.Future<_i2.StreamedResponse> send(_i2.BaseRequest? request) =>
      (super.noSuchMethod(
        Invocation.method(
          #send,
          [request],
        ),
        returnValue:
            _i4.Future<_i2.StreamedResponse>.value(_FakeStreamedResponse_1(
          this,
          Invocation.method(
            #send,
            [request],
          ),
        )),
      ) as _i4.Future<_i2.StreamedResponse>);

  @override
  void close() => super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValueForMissingStub: null,
      );
}