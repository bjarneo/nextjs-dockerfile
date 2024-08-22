# Use a lightweight base image
FROM node:20-alpine as base

# Set the working directory
WORKDIR /app

# Copy the package files
COPY package*.json ./

# Install dependencies
RUN npm ci --production

# Copy the Next.js application code
COPY . .

# Build the Next.js application
# The build command depends on the lockfile that is present
RUN \
    if [ -f yarn.lock ]; then yarn run build; \
    elif [ -f package-lock.json ]; then npm run build; \
    elif [ -f pnpm-lock.yaml ]; then corepack enable pnpm && pnpm run build; \
    else echo "Lockfile not found." && exit 1; \
    fi

# Create a new stage for the runtime environment
FROM node:20-alpine as runtime

# Set the working directory
WORKDIR /app

# Copy the built Next.js application from the previous stage
COPY --from=base /app .

# Create a non-root user with a fixed UID and GID
RUN addgroup -g 1001 nextjs && \
    adduser -u 1001 -G nextjs -s /bin/sh -D nextjs

# Set the non-root user as the default user
USER nextjs

# Expose the port that the Next.js application will run on
EXPOSE 3000

# Start the Next.js application
CMD ["npm", "start"]
