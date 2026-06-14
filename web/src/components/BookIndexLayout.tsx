import { Fragment } from 'react';

interface Section {
  id: string;
  title: string;
  level: number;
}

interface BookIndexLayoutProps {
  sections: Section[];
  slug: string;
}

export function BookIndexLayout({ sections, slug }: BookIndexLayoutProps) {
  return (
    <nav className="book-index-layout mb-8 border-b border-gray-200 pb-6">
      <h2 className="text-lg font-semibold text-gray-900 mb-3">On this page</h2>
      <ul className="space-y-1">
        {sections.map((s) => (
          <li key={s.id}>
            <a
              href={`/books/${slug}#${s.id}`}
              className={`block text-sm ${s.level === 3 ? 'pl-4 text-gray-500' : 'text-gray-700 font-medium'} hover:text-blue-600 transition-colors`}
            >
              {s.title}
            </a>
          </li>
        ))}
      </ul>
    </nav>
  );
}
