export { BookTableOfContents } from '../components/BookTableOfContents';

export function BookHeader(props: {
  title: string;
  subtitle?: string;
  authors?: string[];
  isbn?: string;
  publisher?: string;
  pubDate?: string;
  year?: string | number;
  pages?: number;
  coverImage?: string;
  readingTime?: string;
  rating?: number;
}) {
  const { title, subtitle, authors, isbn, publisher, pubDate, year, pages, coverImage, readingTime, rating } = props;
  return (
    <header className="book-header-detailed mb-8 border-b border-gray-200 pb-6">
      <h1 className="text-3xl font-bold text-gray-900">{title}</h1>
      {subtitle && <p className="mt-1 text-lg text-gray-600">{subtitle}</p>}
      <dl className="mt-4 grid grid-cols-2 gap-x-6 gap-y-1 text-sm text-gray-600">
        {authors ? <><dt className="font-medium">Authors</dt><dd>{authors.join(', ')}</dd></> : null}
        {isbn ? <><dt className="font-medium">ISBN</dt><dd>{isbn}</dd></> : null}
        {publisher ? <><dt className="font-medium">Publisher</dt><dd>{publisher}</dd></> : null}
        {(pubDate || year) ? <><dt className="font-medium">Published</dt><dd>{pubDate || String(year)}</dd></> : null}
        {pages != null ? <><dt className="font-medium">Pages</dt><dd>{pages}</dd></> : null}
        {readingTime ? <><dt className="font-medium">Reading Time</dt><dd>{readingTime}</dd></> : null}
        {rating != null ? <><dt className="font-medium">Rating</dt><dd>{'★'.repeat(rating)}{'☆'.repeat(5 - rating)}</dd></> : null}
      </dl>
    </header>
  );
}
