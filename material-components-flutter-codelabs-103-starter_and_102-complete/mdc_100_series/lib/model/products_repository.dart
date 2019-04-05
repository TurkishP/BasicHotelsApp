// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'product.dart';

const allProducts = <Product>[
  Product(
    category: Category.accessories,
    id: 0,
    isFeatured: true,
    name: 'Hilton Rome',
    price: 3,
    location: '7960 Green Lake Lane Fort Lee, NJ 07024',
    phoneNum: "+48 22 318 22 00",
    detail:
        "Its sometimes her behaviour are contented. Do listening am eagerness oh objection collected. Together gay feelings continue juvenile had off one. Unknown may service subject her letters one bed. Child years noise ye in forty. Loud in this in both hold. My entrance me is disposal bachelor remember relation. ",
    favorited: false,
  ),
  Product(
    category: Category.accessories,
    id: 1,
    isFeatured: true,
    name: 'The Plaza',
    price: 4,
    location: '8585 Buttonwood Dr. Wallingford, CT 06492',
    phoneNum: "+48 23 378 99 10",
    detail:
        "He share of first to worse. Weddings and any opinions suitable smallest nay. My he houses or months settle remove ladies appear. Engrossed suffering supposing he recommend do eagerness. Commanded no of depending extremity recommend attention tolerably. ",
    favorited: false,
  ),
  Product(
    category: Category.accessories,
    id: 2,
    isFeatured: false,
    name: 'Beverly Hills',
    price: 4,
    location: '3 Beech Ave. Springfield, PA 19064',
    phoneNum: "+48 42 512 22 54",
    detail:
        "Sussex result matter any end see. It speedily me addition weddings vicinity in pleasure. Happiness commanded an conveying breakfast in. Regard her say warmly elinor. Him these are visit front end for seven walls. Money eat scale now ask law learn. Side its they just any upon see last.",
    favorited: false,
  ),
  Product(
    category: Category.accessories,
    id: 3,
    isFeatured: true,
    name: 'The Peninsula',
    price: 5,
    location: '966 Marvon Rd. Corpus Christi, TX 78418',
    phoneNum: "+53 223 12 13 56",
    detail:
        "Projecting surrounded literature yet delightful alteration but bed men. Open are from long why cold. If must snug by upon sang loud left. As me do preference entreaties compliment motionless ye literature. Day behaviour explained law remainder. ",
    favorited: false,
  ),
  Product(
    category: Category.accessories,
    id: 4,
    isFeatured: false,
    name: 'InterContinental',
    price: 5,
    location: '141 Colonial St.Muscatine, IA 52761',
    phoneNum: "+80 32 412 55 44",
    detail:
        "Imagine was you removal raising gravity. Unsatiable understood or expression dissimilar so sufficient. Its party every heard and event gay. Advice he indeed things adieus in number so uneasy. To many four fact in he fail. My hung it quit next do of. ",
    favorited: false,
  ),
  Product(
    category: Category.accessories,
    id: 5,
    isFeatured: false,
    name: 'Marriott New York',
    price: 4,
    location: '5 Andover Avenue Elizabeth, NJ 07202',
    phoneNum: "+44 55 666 77 89",
    detail:
        "To sorry world an at do spoil along. Incommode he depending do frankness remainder to. Edward day almost active him friend thirty piqued. People as period twenty my extent as. Set was better abroad ham plenty secure had horses. ",
    favorited: false,
  )
];

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    if (category == Category.all) {
      return allProducts;
    } else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }

  static Product loadProduct(int id) {
    return allProducts.firstWhere((Product) => Product.id == id,
        orElse: () => null);
  }
}
