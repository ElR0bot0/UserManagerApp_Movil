// Mocks generated by Mockito 5.4.4 from annotations
// in f_simple_web_retool/test/mocks/user_test.mocks.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:convert' as _i7;
import 'dart:typed_data' as _i9;

import 'package:f_testing_template/data/datasources/remote/client_remote_datasource.dart'
    as _i6;

import 'package:f_testing_template/domain/entities/client.dart' as _i5;
import 'package:f_testing_template/data/repositories/client_repository.dart'
    as _i3;
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

/// A class which mocks [ClientRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIUserRepository extends _i1.Mock implements _i3.ClientRepository {
  MockIUserRepository() {
    _i1.throwOnMissingStub(this);
  }
  @override
  Future<bool> addClient(_i5.Client clienti) => (super.noSuchMethod(
        Invocation.method(#addClient, [clienti]),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  Future<List<_i5.Client>> getAllClients() => (super.noSuchMethod(
        Invocation.method(#getAllClients, []),
        returnValue: _i4.Future<List<_i5.Client>>.value(<_i5.Client>[]),
      ) as _i4.Future<List<_i5.Client>>);
  @override
  Future<bool> deleteClient(String id) => (super.noSuchMethod(
        Invocation.method(#deleteClient, [id]),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  Future<bool> updateClient(_i5.Client client) => (super.noSuchMethod(
        Invocation.method(#updateClient, [client]),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  Future<_i5.Client?> getClientById(String id) => (super.noSuchMethod(
        Invocation.method(#getClientById, [id]),
        returnValue: _i4.Future<_i5.Client?>.value(
            _FakeResponse_0(this, Invocation.method(#getClientById, [id]))),
      ) as _i4.Future<_i5.Client?>);

  @override
  Future<_i5.Client?> getClientByEmail(String email) => (super.noSuchMethod(
        Invocation.method(#getClientByEmail, [email]),
        returnValue: _i4.Future<_i5.Client?>.value(
            _FakeResponse_0(this, Invocation.method(#getClientById, [email]))),
      ) as _i4.Future<_i5.Client?>);
}

/// A class which mocks [ClientRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockIUserDataSource extends _i1.Mock
    implements _i6.ClientRemoteDataSource {
  MockIUserDataSource() {
    _i1.throwOnMissingStub(this);
  }
  @override
  Future<bool> addClient(_i5.Client clienti) => (super.noSuchMethod(
        Invocation.method(#addClient, [clienti]),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  Future<List<_i5.Client>> getAllClients() => (super.noSuchMethod(
        Invocation.method(#getAllClients, []),
        returnValue: _i4.Future<List<_i5.Client>>.value(<_i5.Client>[]),
      ) as _i4.Future<List<_i5.Client>>);
  @override
  Future<bool> deleteClient(String id) => (super.noSuchMethod(
        Invocation.method(#deleteClient, [id]),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  Future<bool> updateClient(_i5.Client client) => (super.noSuchMethod(
        Invocation.method(#updateClient, [client]),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
  @override
  Future<_i5.Client?> getClientById(String id) => (super.noSuchMethod(
        Invocation.method(#getClientById, [id]),
        returnValue: _i4.Future<_i5.Client?>.value(
            _FakeResponse_0(this, Invocation.method(#getClientById, [id]))),
      ) as _i4.Future<_i5.Client?>);
  @override
  Future<_i5.Client?> getClientByEmail(String email) => (super.noSuchMethod(
        Invocation.method(#getClientByEmail, [email]),
        returnValue: _i4.Future<_i5.Client?>.value(
            _FakeResponse_0(this, Invocation.method(#getClientById, [email]))),
      ) as _i4.Future<_i5.Client?>);
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