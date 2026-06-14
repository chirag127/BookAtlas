interface MermaidProps {
  chart: string;
}

export function Mermaid({ chart }: MermaidProps) {
  return (
    <div className="mermaid-wrapper my-6 p-4 bg-gray-50 rounded-lg border border-gray-200 overflow-x-auto">
      <pre className="text-xs text-gray-600 font-mono whitespace-pre">
        <code>{chart}</code>
      </pre>
      <p className="mt-2 text-xs text-gray-400 italic">
        Mermaid diagram rendering requires a browser-based Mermaid library.
        Below is the source definition:
      </p>
    </div>
  );
}
