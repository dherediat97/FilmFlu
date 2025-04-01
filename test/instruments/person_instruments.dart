import 'package:film_flu/domain/models/credit_actor_entity.dart';
import 'package:film_flu/domain/models/credit_production_entity.dart';
import 'package:film_flu/domain/models/credits_person_entity.dart';
import 'package:film_flu/domain/models/person_entity.dart';

class PersonDetailIntruments {
  static const String personIdMocked = '10859';
  static PersonEntity personMocked = const PersonEntity(
    biography:
        'Ryan Rodney Reynolds (23 de octubre de 1976) es un actor canadiense.\n\nEl éxito y el reconocimiento le llegaron con su participación en la comedia titulada Two Guys and a Girl (1998-2001), antes de que iniciara su carrera de comediante y actor dramático para la industria de cine de Hollywood. Es reconocido por sus intervenciones en producciones como Blade: Trinity (2004), The Amityville Horror (2005), Definitely, Maybe (2008), X-Men Origins: Wolverine (2009), The Proposal (2009), Buried (2010), Linterna Verde (2011) y en la adaptación cinematográfica del cómic Deadpool (2016) y su secuela, Deadpool 2.  En 2010 la revista estadounidense People lo eligió como el hombre más sexy del año.',
    birthday: '1976-10-23',
    deathday: '',
    gender: 2,
    alias: ['Ryan Reynolds'],
    id: 10859,
    name: 'Ryan Reynolds',
    placeOfBirth: 'Vancouver, British Columbia, Canada',
    profilePath: '/2Orm6l3z3zukF1q0AgIOUqvwLeB.jpg',
    credits: CreditsPersonEntity(
      cast: [
        CreditActorEntity(
          genreIds: [35, 10749],
          id: 10065,
          originalTitle: 'Just Friends',
          title: 'Sólo amigos',
          popularity: 23.845,
        ),
        CreditActorEntity(
          genreIds: [27, 53],
          id: 10033,
          originalTitle: 'The Amityville Horror',
          title: 'La morada del miedo',
          popularity: 23.845,
        ),
      ],
      crew: [
        CreditProductionEntity(
          genreIds: [99],
          id: 10033,
          originalTitle: 'The Whale',
          title: 'The Whale',
          popularity: 6.71,
        ),
        CreditProductionEntity(
          genreIds: [28, 12, 35],
          id: 77880,
          originalTitle: 'Deadpool',
          title: 'Deadpool',
          popularity: 258.378,
        ),
      ],
    ),
  );
}
