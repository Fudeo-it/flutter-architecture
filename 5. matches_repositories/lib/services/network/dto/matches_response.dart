import 'package:equatable/equatable.dart';

import 'match_dto.dart';

class MatchesResponse extends Equatable {
  final String get;
  final ParametersDTO parameters;
  final Map<String, String>? errors;
  final int results;
  final PagingDTO paging;
  final List<MatchDTO> response;

  const MatchesResponse({
    required this.get,
    required this.parameters,
    required this.errors,
    required this.results,
    required this.paging,
    required this.response,
  });

  factory MatchesResponse.fromJson(Map<String, dynamic> data) =>
      MatchesResponse(
        get: data['get'],
        parameters: ParametersDTO.fromJson(data['parameters']),
        errors: data.containsKey('errors') ? data['errors'] : null,
        results: data['results'],
        paging: PagingDTO.fromJson(data['paging']),
        response: (data['response'] as List)
            .map((item) => MatchDTO.fromJson(item as Map<String, dynamic>))
            .toList(growable: false),
      );

  @override
  List<Object?> get props => [
    get,
    parameters,
    errors,
    results,
    paging,
    response,
  ];
}

class ParametersDTO extends Equatable {
  final String date;

  const ParametersDTO(this.date);

  factory ParametersDTO.fromJson(Map<String, dynamic> data) =>
      ParametersDTO(data['date']);

  @override
  List<Object?> get props => [date];
}

class PagingDTO extends Equatable {
  final int current;
  final int total;

  const PagingDTO(this.current, this.total);

  factory PagingDTO.fromJson(Map<String, dynamic> data) => PagingDTO(
    data['current'],
    data['total'],
  );

  @override
  List<Object?> get props => [current, total];
}

