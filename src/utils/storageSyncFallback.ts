import browser from 'webextension-polyfill'

/**
 * Safely reads all items from storage.sync.
 * On Safari, storage.sync may throw when iCloud is not enabled.
 * Falls back to an empty object when unavailable.
 */
export async function safeSyncStorageGetAll(): Promise<Record<string, unknown>> {
  try {
    return await browser.storage.sync.get(null) as Record<string, unknown>
  }
  catch (error) {
    console.warn('[BewlyCat] storage.sync is not available (Safari without iCloud?). Falling back to empty sync state.', error)
    return {}
  }
}

/**
 * Safely writes items to storage.sync.
 * On Safari, storage.sync may throw when iCloud is not enabled.
 * Gracefully handles the failure.
 */
export async function safeSyncStorageSet(items: Record<string, unknown>): Promise<void> {
  try {
    await browser.storage.sync.set(items)
  }
  catch (error) {
    console.warn('[BewlyCat] storage.sync write failed. Cloud sync disabled.', error)
  }
}