Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47337F513
	for <audit@vger.kernel.org>; Thu,  5 Feb 2026 04:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770266723; cv=none; b=HPaCmwaGtKnA1BuwFh+up9E4xcieZSX7TvIWcPL4YGcl9K7/rG8YTApbkPcN6HXjxbgyc31d0CMduezmEDAXb3rAzpyVCZZSI9BjF1mJq0qMv5PsrNmPVvNksCdKHaa8dpEADM5M5i3cUnJVi9vVgZ+k8s5887nwTduLJCQ+ROE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770266723; c=relaxed/simple;
	bh=+huLvsHnEPNe+COSmu1uEIg9G8zeseh4VCf73AbemIQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jkbivF9oPptwF7Qcez3x5yYvtwvgYKR/LMnV1SBezvHRL/2dOut5T3JTn/Y7G++YyKjhHZmOHcfu3wJFFqVbwlGSQf78szuoNr2Tww64ThXSE9a8556DK3wOCZnyGkGfrtam3oEM6knIAm73WDY2RZTAMWGeJo9UNZ8q/l3HVwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LC7hlak9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LC7hlak9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770266722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10MUqzroLzmxLSL4NYapveobUZJ+rjSHt7evnfwhT9M=;
	b=LC7hlak9UtQKH8RCa+Wv0O+yvRKV6F7EIHrWDYfABEmSIV8xxA2bgFbUVUoqO8ubmCMRJj
	8QIeotU6lfOCLxtQRBJasCu3eKsBWadidnxHQ/Xx/6ykAaK6JsKu1LrlRlCGlneRMbPX5A
	Seasq7530JQfzDgrn9cO0RTECuFMBmk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-f4uaqVfAOx2TIOGPb4jI1g-1; Wed, 04 Feb 2026 23:45:20 -0500
X-MC-Unique: f4uaqVfAOx2TIOGPb4jI1g-1
X-Mimecast-MFC-AGG-ID: f4uaqVfAOx2TIOGPb4jI1g_1770266720
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6a87029b6so149680485a.1
        for <audit@vger.kernel.org>; Wed, 04 Feb 2026 20:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770266720; x=1770871520;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=10MUqzroLzmxLSL4NYapveobUZJ+rjSHt7evnfwhT9M=;
        b=kpXaGCXx5saZT0dZ0rXI/lJH5dWW4B4UjGlDc42qrymqHSvHeWQbWdwGQJJFHEfL4v
         by0KRnu/MPSgiIPgoKJry2n/pFcq5Ysoe1w86BnvjNUFxGPMFQyQq8lP4wRExJoQ4NA1
         ty8A8Idk9zyKGVpxsBHvZkz3hjfXjASYsZp/VhO46LP9CZrXemjiFm3/uYeGSnNjeFK1
         5kF27cOES+9ol998lgx3dnttk2qJjBkgFtsf8Ofo/Q2mHfHEbGdrk25lpc1LygYHMFuz
         WQJ+fMXvrEyvJZSUvQOpS2ddnJfLerpRLVVGeMcvV4ccGMok4rmJauNh1x9TtU42p33b
         mwNA==
X-Forwarded-Encrypted: i=1; AJvYcCWPo4qeEQqfVTRcaEfDDaiNFBisIl55Ym8ViMSnhVkh7NS/+KrX55EK1XxAenLL6m+ZkZhdww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoSMqEPAxRkDDIDq4+wLk+zYZI++SbU1q7DBWEfBZjpqqlpKzr
	wuz+RNkdiAiGhL0btYtlsuQmvYz2PxTPQTm5EYmaWVuCDhToRr17oMQaZYaK53hdJBMqVK7a1Ej
	HlAsgArAdxjY05LsN9W//hnnHhg/wxXRrWnyoPiwLLnfKnyGemcvT6F7z
X-Gm-Gg: AZuq6aIiW74K8ihjSwb2lUuPJNrSD/a0M+8E51SrYhEHFk6MnGfFMN88CYYwXc80+El
	gt0uSl0meiMSkgDpqINcm53TNhVVUKwHR+VH67feKbrzex8dUMn1H+dM8ARb01R09/PnUjiDN4Q
	W597m2jo3s+nkDXyzX6NfwcPd6ySdbe0eNenFnqmeNhfY1Y8tUbJhu895daKAPJqpCS2drb+hhC
	Zfgp6HCF+uRdMjSShmBa9KALWmt3LPpawOO39CWJCjE/V7DfK2O2H7lvN3vAcCmt7bWWQ7s22tz
	ku4nOyLV5cv3bZPwgdtBZSgrODAMQMh6DFFcbRocmHnyjD2uP2lszfpjyM4/KRIFqXOqb6qRKil
	i4ntGevp+enWPk90c3wb2TuEYsp+Hz3UeeoI9FI+G3vPeXI/sWXpkGzzY
X-Received: by 2002:a05:620a:40c8:b0:8c6:d2ca:1d0e with SMTP id af79cd13be357-8ca2f81cb4dmr673615085a.11.1770266719846;
        Wed, 04 Feb 2026 20:45:19 -0800 (PST)
X-Received: by 2002:a05:620a:40c8:b0:8c6:d2ca:1d0e with SMTP id af79cd13be357-8ca2f81cb4dmr673613785a.11.1770266719387;
        Wed, 04 Feb 2026 20:45:19 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521d1338fsm33633226d6.41.2026.02.04.20.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 20:45:18 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <50054d23-0a89-41ec-b28b-b1ed77d93b00@redhat.com>
Date: Wed, 4 Feb 2026 23:45:17 -0500
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audit: Avoid excessive dput/dget in audit_context
 setup and reset paths
To: Waiman Long <llong@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>
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
 <46d5c480-87d0-4f6a-bcc2-6c936c87e216@redhat.com>
 <20260204201815.GP3183987@ZenIV>
 <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
In-Reply-To: <cbaab46e-715d-4d06-80af-320caec7feb7@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ISWzJ6PIiMiYlQeTxDAjcvBP6VeFagmokpVm9Z3sAUo_1770266720
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/4/26 10:03 PM, Waiman Long wrote:
> On 2/4/26 3:18 PM, Al Viro wrote:
>> On Wed, Feb 04, 2026 at 01:16:15PM -0500, Waiman Long wrote:
>>
>>
>>> Thanks for the detailed explanation. I am thinking about something like
>>> the code diff below. Of course, there are other corner cases like 
>>> unshare(2)
>>> that still needs to be handled. Do you think something like this is 
>>> viable?
>> Deadlocks aside, the immediate problem here is that consensus number 
>> is too
>> low.  Take three threads sharing the same fs_struct instance. The 
>> first one
>> calls your get_fs_pwd_share(); then the remaining two threads call 
>> set_fs_pwd()
>> (e.g. by calling chdir(2) in userland code).  The reference stored into
>> fs->pwd_waiter by the first of those two gets overwritten by that stored
>> by the second.  When the caller of get_fs_pwd_share() gets to 
>> put_fs_pwd_share(),
>> only one of the sleepers gets woken up...
>>
>> And it's very easy to end up with something as simple as chdir("foo") 
>> deadlocking -
>> we start with resolving the relative pathname we'd been given, audit 
>> wants to
>> record the current directory, on the theory that relative pathname is 
>> none too
>> useful in logs without knowing what had it been relative to. Then, in 
>> the
>> same thread, you call set_fs_pwd() - after all, that's the main 
>> effect of chdir(2).
>> Deadlock...
>>
>> IOW, it's not just unshare(2) that needs to be taken care of - 
>> chdir(2) would need
>> to be treated differently.
>
> Now I realize that there is indeed a deadlock problem. Scrap that. Now 
> I have a simpler idea that shouldn't have this type of deadlock 
> problem. So what do you think about the sample code below? 

Well, a complete change log is as follows.

Cheers,
Longman

=======================[ Cut here ]================================

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index b8c46c5a38a0..67e08d8db058 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -32,15 +32,19 @@ void set_fs_root(struct fs_struct *fs, const struct 
path *p>
  void set_fs_pwd(struct fs_struct *fs, const struct path *path)
  {
         struct path old_pwd;
+       int count;

         path_get(path);
         write_seqlock(&fs->seq);
         old_pwd = fs->pwd;
         fs->pwd = *path;
+       count = fs->pwd_xrefs + 1;
+       fs->pwd_xrefs = 0;
         write_sequnlock(&fs->seq);

         if (old_pwd.dentry)
-               path_put(&old_pwd);
+               while (count--)
+                       path_put(&old_pwd);
  }

  static inline int replace_path(struct path *p, const struct path *old, 
const s>
@@ -70,6 +74,8 @@ void chroot_fs_refs(const struct path *old_root, const 
struct>
                                 count++;
                                 path_get(new_root);
                         }
+                       count += fs->pwd_xrefs;
+                       fs->pwd_xrefs = 0;
                         write_sequnlock(&fs->seq);
                 }
                 task_unlock(p);
@@ -81,8 +87,11 @@ void chroot_fs_refs(const struct path *old_root, 
const struc>

  void free_fs_struct(struct fs_struct *fs)
  {
+       int count = fs->pwd_xrefs + 1;
+
         path_put(&fs->root);
-       path_put(&fs->pwd);
+       while (count--)
+               path_put(&fs->pwd);
         kmem_cache_free(fs_cachep, fs);
  }

@@ -110,6 +119,7 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
         if (fs) {
                 fs->users = 1;
                 fs->in_exec = 0;
+               fs->pwd_xrefs = 0;
                 seqlock_init(&fs->seq);
                 fs->umask = old->umask;

diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index 0070764b790a..0d79d51de240 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -8,10 +8,11 @@
  #include <linux/seqlock.h>

  struct fs_struct {
-       int users;
         seqlock_t seq;
+       int users;
         int umask;
         int in_exec;
+       int pwd_xrefs;  /* Extra references of pwd */
         struct path root, pwd;
  } __randomize_layout;

@@ -40,6 +41,31 @@ static inline void get_fs_pwd(struct fs_struct *fs, 
struct p>
         read_sequnlock_excl(&fs->seq);
  }

+static inline void get_fs_pwd_share(struct fs_struct *fs, struct path *pwd)
+{
+       read_seqlock_excl(&fs->seq);
+       *pwd = fs->pwd;
+       if (fs->pwd_xrefs)
+               fs->pwd_xrefs--;
+       else
+               path_get(pwd);
+       read_sequnlock_excl(&fs->seq);
+}
+
+static inline void put_fs_pwd_share(struct fs_struct *fs, struct path *pwd)
+{
+       bool put = false;
+
+       read_seqlock_excl(&fs->seq);
+       if ((fs->pwd.dentry == pwd->dentry) && (fs->pwd.mnt == pwd->mnt))
+               fs->pwd_xrefs++;
+       else
+               put = true;
+       read_sequnlock_excl(&fs->seq);
+       if (put)
+               path_put(pwd);
+}
+
  extern bool current_chrooted(void);

  static inline int current_umask(void)

