//Core Packages
import 'dart:convert';
import 'package:FilmFlu/modules/shared/drivers/local_storage/local_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

//My Packages
import 'package:FilmFlu/dto/video.dart';
import 'package:FilmFlu/modules/movies/domain/entities/media_item.dart';
import 'package:FilmFlu/core/constants/constants.dart';
import 'package:FilmFlu/dto/person.dart';
import 'package:FilmFlu/modules/movies/domain/entities/credits.dart';
import 'package:FilmFlu/dto/credit_person.dart';
import 'package:FilmFlu/dto/credits_person.dart';

class Api {
  MediaItem parseMovie(String responseBody) {
    final parsed = jsonDecode(responseBody);
    MediaItem mediaItem = MediaItem.fromJson(parsed);
    return mediaItem;
  }

  List<MediaItem> parseMediaItems(String responseBody) {
    final parsed = jsonDecode(responseBody)['results'];
    return parsed.map<MediaItem>((json) => MediaItem.fromJson(json)).toList();
  }

  CreditsPerson parseCreditsPerson(String responseBody) {
    final parsed = jsonDecode(responseBody);
    CreditsPerson credits = CreditsPerson.fromJson(parsed);
    return credits;
  }

  Credits parseCredits(String responseBody) {
    final parsed = jsonDecode(responseBody);
    Credits credits = Credits.fromJson(parsed);
    return credits;
  }

  Person parsePerson(String responseBody) {
    final parsed = jsonDecode(responseBody);
    Person person = Person.fromJson(parsed);
    return person;
  }

  List<Credits> parsePersonCredits(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed
        .map<CreditPerson>((json) => CreditPerson.fromJson(json))
        .toList();
  }

  Video parseVideo(String responseBody) {
    final parsed = jsonDecode(responseBody)["results"][0];
    return Video.fromJson(parsed);
  }

  Future<List<MediaItem>> fetchPopularMediaTypes(
      String trendingType, String mediaType) async {
    String language = "";
    await getLocale().then(
        (value) => language = "${value.languageCode}-${value.countryCode}");
    final response = await Client().get(
        Uri.parse(
            '$baseURL/trending/${mediaType}/$trendingType?language=$language'),
        headers: baseHeaders);
    return compute(parseMediaItems, response.body);
  }

  Future<MediaItem> fetchMovie(String mediaTypeId, String mediaType) async {
    String language = "";
    await getLocale().then(
        (value) => language = "${value.languageCode}-${value.countryCode}");
    final response = await Client().get(
        Uri.parse('$baseURL/${mediaType}/${mediaTypeId}?language=$language'),
        headers: baseHeaders);
    return compute(parseMovie, response.body);
  }

  Future<Video> fetchTrailer(
      String movieId, String? language, String mediaType) async {
    String language = "";
    await getLocale().then(
        (value) => language = "${value.languageCode}-${value.countryCode}");
    final response = await Client().get(
        Uri.parse('$baseURL/${mediaType}/${movieId}/videos?language=$language'),
        headers: baseHeaders);
    return compute(parseVideo, response.body);
  }

  Future<Credits> fetchCredits(String movieId, String mediaType) async {
    String language = "";
    await getLocale().then(
        (value) => language = "${value.languageCode}-${value.countryCode}");
    final response = await Client().get(
        Uri.parse(
            '$baseURL/${mediaType}/${movieId}/credits?language=$language'),
        headers: baseHeaders);
    return compute(parseCredits, response.body);
  }

  Future<List<MediaItem>> searchMovie(String movieSearched) async {
    final response = await Client().get(
        Uri.parse(
            '$baseURL/search/movie?query=${movieSearched}&include_adult=false&page=1'),
        headers: baseHeaders);
    return compute(parseMediaItems, response.body);
  }

  Future<Person> fetchPerson(String personId) async {
    String language = "";
    await getLocale().then(
        (value) => language = "${value.languageCode}-${value.countryCode}");
    final response = await Client().get(
        Uri.parse('$baseURL/person/${personId}?language=$language'),
        headers: baseHeaders);
    return compute(parsePerson, response.body);
  }

  Future<CreditsPerson> fetchPersonCredits(String personId) async {
    String language = "";
    await getLocale().then(
        (value) => language = "${value.languageCode}-${value.countryCode}");
    final response = await Client().get(
        Uri.parse(
            '$baseURL/person/${personId}/combined_credits?language=$language'),
        headers: baseHeaders);
    return compute(parseCreditsPerson, response.body);
  }
}
