interface BookCardProps {
  title: string;
  slug: string;
  description?: string;
  related?: boolean;
}

export function BookCard({ title, slug, description, related }: BookCardProps) {
  return (
    <article className="book-card rounded-lg border border-gray-200 bg-white p-6 shadow-sm transition hover:shadow-md">
      <a href={`/books/${slug}`} className="block">
        <h3 className="text-xl font-semibold text-gray-900">{title}</h3>
        {description && <p className="mt-2 text-sm text-gray-600">{description}</p>}
        {related && <span className="mt-2 inline-block text-xs text-blue-600 font-medium">Related Reading</span>}
      </a>
    </article>
  );
}
