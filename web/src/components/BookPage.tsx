import { type ReactNode } from 'react';

interface BookPageProps {
  title: string;
  author: string;
  year: string;
  isbn?: string;
  pages?: number;
  language?: string;
  category?: string;
  rating?: number;
  children?: ReactNode;
}

export function BookPage({ title, author, year, isbn, pages, language, category, rating, children }: BookPageProps) {
  return (
    <article className="book-page">
      <header className="book-page-header mb-6 border-b border-gray-200 pb-4">
        <h1 className="text-3xl font-bold text-gray-900">{title}</h1>
        <dl className="mt-3 grid grid-cols-2 gap-2 text-sm text-gray-600">
          {author && <><dt className="font-medium">Author</dt><dd>{author}</dd></>}
          {year && <><dt className="font-medium">Year</dt><dd>{year}</dd></>}
          {isbn && <><dt className="font-medium">ISBN</dt><dd>{isbn}</dd></>}
          {pages != null && <><dt className="font-medium">Pages</dt><dd>{pages}</dd></>}
          {language && <><dt className="font-medium">Language</dt><dd>{language}</dd></>}
          {category && <><dt className="font-medium">Category</dt><dd>{category}</dd></>}
          {rating != null && <><dt className="font-medium">Rating</dt><dd>{'★'.repeat(rating)}{'☆'.repeat(5 - rating)}</dd></>}
        </dl>
      </header>
      {children}
    </article>
  );
}
