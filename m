Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D633E37C
	for <audit@vger.kernel.org>; Wed,  4 Feb 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770228981; cv=none; b=ac/jWmWucQzJnlSQjcKjBhEZxOU0J5PCu68QzHnq2n9EilWjejVMftZEE0TZ+/T4z6iRU7XKuE43XDWFRAtKPWwGl+PhO9yxTQ95YaffcH1DW9d5VP/zL8P6ih8jbSt0lcWhA1nU5iesVNwLsvCSbFosSGDqe2WAVtyvpaQCYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770228981; c=relaxed/simple;
	bh=jxUGSbafBVOeo4YVIEroTpfWhgu9nLcAcQdyGA5hHbs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=U8MR6S6Q9O79QHV+p5aDR5RHk66NOo3Ahpn3hNt5o5TUI/d1w+FF5ViBXsH4eNhQLOW9ci9d78wXdfJUgVhgY00UHxO2v92etHAMZi/FRwbwwvsM7pwgKJyMsDq+itv9j0JkGN4bDhmT8EfAsG351F2/zNDjGHbLiAUBmGXiVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLHQ06Zp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLHQ06Zp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770228979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCL3Cm+Z0d+kZcWyu1dMmuNDXI8bD0nxr3EWpTI/qh8=;
	b=OLHQ06ZpHCuWgY+E86RpcKE1LM1VhZKDF6Ayd+rwzCZBTRcLxeBrT6zEAAtV/dVyi7uQ27
	Fwf3pXD6BNMUaJS3OuftjLkAndrRVeGrRWCZ/uVR4ouX6B5Rh4fFlpfSokJQNBqh0NUPlp
	lvv7Nnaa4NlxjXDJ4onpmeyWTscF710=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-SgSvCkO4PKq0nbbypwaCSQ-1; Wed, 04 Feb 2026 13:16:18 -0500
X-MC-Unique: SgSvCkO4PKq0nbbypwaCSQ-1
X-Mimecast-MFC-AGG-ID: SgSvCkO4PKq0nbbypwaCSQ_1770228978
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5033c483b74so92901cf.2
        for <audit@vger.kernel.org>; Wed, 04 Feb 2026 10:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770228978; x=1770833778;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCL3Cm+Z0d+kZcWyu1dMmuNDXI8bD0nxr3EWpTI/qh8=;
        b=W2YBrV8rQfKfF3P7DIQ6IojH3hFbuj9eil4ltI7vLYabURjHcFaWEC4kJiA3jZ+fFk
         Scz04GPGehjUgl5pqJjEzj0dJ7BGxjkHL1R+R2I3l3bIa4tRoBfzCduDM6TJM2HCBHTn
         nAmiW208b3iZGgR3IAcI4hDbTYrxuHgqFQO57OFp7PRFdlMxg6iivYFEq/YG+gZFsL7b
         XQ8jvrb0em7q5a6lZJlUPaSXYVhYvQ1N/u1hI6YEWrxNCS9ZGaeG2BVhRHOZ/OOSUcAh
         BQ+Hdo5EF/DK4IpFnjVnUoPqyo2TvziDyqb+5p6jJsDjbuE3CusPXlZK4V5Es8et52n8
         C3hA==
X-Forwarded-Encrypted: i=1; AJvYcCW78k6gDoY0ze2l+4bHgQJY7uKM3mkdtWm2xEBUZ1RaT5Kc3UtUcDRhg5Q0AWdmPjljqUuIXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWp5yYuFbe7nUxwhlfbHSi5+M9Zlnrq5rnGa/16pbjSSlVSqPs
	dfy7G0ORa5iER3T1StLcso0WE3ocByC0NqfTXCC3cR+RSI4DNI79pNuStni3omyPAPHC9EekniW
	VMjsuxOsHtfOgOR++DJW6lOJXm66s3Dv9uHrdOeIBHx4/Ea+FLPjeeeId
X-Gm-Gg: AZuq6aJxSK9edMO82hX8ueaKnt8/Oh8Jmjy02F8yj9UxM1k2zCtUZbqmN8HXV59bY7D
	Mpz8zwBpDhwV8Q93vWQ37O16EXmMWyzgEzXJ/36tMxa5qnKyg7Oa2r0YJ6lDQDbOc63aFlfmKV0
	fV/RtLlUWSXxsjUYbzlpgadLAdoYtzWBnaK6L3gGyfp1L+7Bfvd/zcThdX7+QRggZFNcpBuuN9U
	wwdqloPT7LBNkUmFBDe8xV3vy01wj8pwJhwApm27YQ1YiSOmpBEnX8Vr7EQAgabQnTvi0/BubfP
	mIS+N+McwR68+Tm/OYoExI8ic1GvUN0g3SkwsEz264K3W6SHe9WYcfF594KXJBHn30jK4PGMXRS
	DjB+nXZfBE/rQjWbfRwVDdGEFJMa3sJGNiFWz3vpqyPztkqKslNZCrfud
X-Received: by 2002:ac8:7f8a:0:b0:502:a28c:f195 with SMTP id d75a77b69052e-5061c0b41a5mr49630551cf.13.1770228977607;
        Wed, 04 Feb 2026 10:16:17 -0800 (PST)
X-Received: by 2002:ac8:7f8a:0:b0:502:a28c:f195 with SMTP id d75a77b69052e-5061c0b41a5mr49629881cf.13.1770228977043;
        Wed, 04 Feb 2026 10:16:17 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c1e9971sm22097291cf.21.2026.02.04.10.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 10:16:16 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
Date: Wed, 4 Feb 2026 13:16:15 -0500
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
To: Al Viro <viro@zeniv.linux.org.uk>, Waiman Long <llong@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 audit@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
 Ricardo Robaina <rrobaina@redhat.com>
References: <20260203194433.1738162-1-longman@redhat.com>
 <20260203200505.GH3183987@ZenIV>
 <590a36e6-8d11-411a-8fcd-d93eef96f0e9@redhat.com>
 <20260203215002.GI3183987@ZenIV> <20260203232634.GJ3183987@ZenIV>
 <6661f966-5235-49ca-bf1f-d1ae2ae32f0d@redhat.com>
 <20260204062614.GK3183987@ZenIV>
In-Reply-To: <20260204062614.GK3183987@ZenIV>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Eqok7HcD_scL6N8mVrQMPPSMk4jGb6qVfj9ZBT7US6I_1770228978
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/4/26 1:26 AM, Al Viro wrote:
> On Tue, Feb 03, 2026 at 11:21:23PM -0500, Waiman Long wrote:
>
>> Interesting. So are you thinking about a reference on the pwd inside the
>> fs_struct?
> No.  fs_struct has pwd pinned - both dentry and mount.
>
> Each thread has a reference to fs_struct instance in its task_struct (task->fs).
>
> It is possible for several threads to have their task->fs pointing to the
> same instance.
>
> A thread may modify its fs_struct pointer, making it point to a different
> fs_struct instance; that happens on unshare(2).  In that case new instance
> is an identical copy of the original one; reference counts of mounts and dentries
> (both for pwd and root) are incremented to account for additional references
> in the copy.  That assignment to current->fs happens under task_lock(current).
>
> A child gets either a reference to identical copy of parent's fs_struct or
> an extra reference to parent's fs_struct.  In either case child->fs is
> set before the child gets to run; as the matter of fact, that happens before
> anyone besides the parent might observe the task_struct of child.
>
> That's it - no other stores to task_struct.fs are ever allowed; no other
> thread can change your reference under you.
>
>
> Other than initializing a new copy, *all* stores to fs_struct.pwd are done
> to current->fs.pwd; access to any other fs_struct instances is read-only.
> The only way another thread might change your pwd is if that thread shares
> fs_struct with you.  They can observe its contents, as long as they take
> care to hold task_lock(your_thread), but no more than that.
>
> What's more, if current->fs is the sole reference to fs_struct instance,
> it will remain such until you spawn a child and set it to share your
> instance (CLONE_FS).  No other thread can gain extra references to it,
> etc.
>
>
> What it means is that if you are holding the sole reference to current->fs,
> current->fs->pwd contents will remain unchanged (and pinning the same mount
> and dentry) through the entire syscall with very few exceptions:
> 	1) you spawn a child with CLONE_FS - that has to be either
> clone(2) or io_uring_setup(2) (the latter - via worker threads).
> 	2) you explicitly modify your pwd - in chdir(2), fchdir(2),
> pivot_root(2), setns(2) (with CLONE_NEWNS; it switches you to the root of
> namespace you've joined)
>
> As long as these exceptions are accounted for, audit could check
> current->fs->users *and* skip incrementing refcounts if it's equal to 1.
> It would need to remember whether these reference had been taken -
> rechecking condition won't work, since other threads might by gone
> by the time we leave the syscall turning "shared" to "not shared".
>
> That way we can avoid grabbing any references in a fairly common
> case.
Thanks for the detailed explanation. I am thinking about something like
the code diff below. Of course, there are other corner cases like unshare(2)
that still needs to be handled. Do you think something like this is viable?

Thanks,
Longman

=========================[ Cut here ]===================================

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index b8c46c5a38a0..09c97059776d 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -25,6 +25,23 @@ void set_fs_root(struct fs_struct *fs, const struct 
path *pa>
                 path_put(&old_root);
  }

+static void unshare_fs_pwd_locked(struct fs_struct *fs)
+{
+       get_task_struct(current);
+       fs->pwd_waiter = current;
+retry:
+       spin_unlock(&fs->seq.lock);
+       /* Sleep until pwd_refs reaches 0 */
+       set_current_state(TASK_UNINTERRUPTIBLE);
+       schedule();
+       spin_lock(&fs->seq.lock);
+       if (fs->pwd_refs)
+               goto retry;
+       __set_current_state(TASK_RUNNING);
+       fs->pwd_waiter = NULL;
+       put_task_struct(current);
+}
+
  /*
   * Replace the fs->{pwdmnt,pwd} with {mnt,dentry}. Put the old values.
   * It can block.
@@ -34,7 +51,15 @@ void set_fs_pwd(struct fs_struct *fs, const struct 
path *pat>
         struct path old_pwd;

         path_get(path);
-       write_seqlock(&fs->seq);
+       /*
+        * As the pwd may be shared with other tasks, we need to break down
+        * the write_seqlock() call to its component spin_lock() and
+        * do_write_seqcount_begin() calls.
+        */
+       spin_lock(&fs->seq.lock);
+       if (unlikely(fs->pwd_refs))
+               unshare_fs_pwd_locked(fs);
+  do_write_seqcount_begin(&fs->seq.seqcount.seqcount);
         old_pwd = fs->pwd;
         fs->pwd = *path;
         write_sequnlock(&fs->seq);
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 0070764b790a..3848189893c7 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -13,6 +13,8 @@ struct fs_struct {
         int umask;
         int in_exec;
         struct path root, pwd;
+       int pwd_refs;
+       struct task_struct *pwd_waiter; /* set_fs_pwd() waiter */
  } __randomize_layout;

  extern struct kmem_cache *fs_cachep;
@@ -40,6 +42,43 @@ static inline void get_fs_pwd(struct fs_struct *fs, 
struct p>
         read_sequnlock_excl(&fs->seq);
  }

+/*
+ * The get_fs_pwd_share/put_fs_pwd_share APIs should only be used by 
callers
+ * that need to keep the pwd references for a short time to avoid blocking
+ * set_fs_pwd() caller for long time.
+ */
+static inline bool get_fs_pwd_share(struct fs_struct *fs, struct path *pwd)
+{
+       bool share = true;
+
+       read_seqlock_excl(&fs->seq);
+       *pwd = fs->pwd;
+       share = !fs->pwd_waiter;
+       if (likely(share))
+               fs->pwd_refs++;
+       else
+               path_get(pwd);
+       read_sequnlock_excl(&fs->seq);
+       return share;
+}
+
+static inline void put_fs_pwd_share(struct fs_struct *fs, struct path 
*pwd, bo>
+{
+       struct task_struct *wakeup_task = NULL;
+
+       if (!share) {
+               path_put(pwd);
+               return;
+       }
+       read_seqlock_excl(&fs->seq);
+       fs->pwd_refs--;
+       if (fs->pwd_waiter && !fs->pwd_refs)
+               wakeup_task = fs->pwd_waiter;
+       read_sequnlock_excl(&fs->seq);
+       if (wakeup_task)
+               wake_up_process(wakeup_task);
+}
+
  extern bool current_chrooted(void);

  static inline int current_umask(void)

